class Admin::UsersController < ApplicationController
  before_action :authenticate_admin! # Ensure only admins can access this action

  def ban
    user = User.find(params[:id])
    user.ban!(params[:duration].to_i.hours) # Pass the duration in hours, or nil for a permanent ban
    redirect_to admin_users_path, notice: "#{user.email} has been banned."
  end

  def unban
    user = User.find(params[:id])
    user.unban!
    redirect_to admin_users_path, notice: "#{user.email} has been unbanned."
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user.has_role?(:admin)
  end
end
