class User < ApplicationRecord
  rolify
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def ban!(duration = nil)
    if duration
      self.banned_until = Time.current + duration
    else
      self.banned_until = 100.years.from_now # Set a far future date for permanent ban
    end
    save!
  end

  def unban!
    self.banned_until = nil
    save!
  end

  def banned?
    banned_until.present? && banned_until > Time.current
  end

  def active_for_authentication?
    super && !banned?
  end

  def inactive_message
    banned? ? :banned : super
  end
end
