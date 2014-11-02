class Message < ActiveRecord::Base
  enum source: [:uploader, :recipient, :autopilot]

  belongs_to :conversation

  validates :body, length: { in: 1..350 }
  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :source, presence: true
  validates :time, presence: true
end
