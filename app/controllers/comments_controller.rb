class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to root_path, notice: 'Comment was successfully created.'
    else
      redirect_to root_path, alert: 'Comment could not be created.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to root_path, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path, notice: 'Comment was successfully deleted.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user!
    unless current_user == @comment.user || current_user.has_role?(:admin)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end