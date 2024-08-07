class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :manga

  validates :content, presence: true
end
