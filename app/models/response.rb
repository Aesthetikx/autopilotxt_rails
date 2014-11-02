class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true
end