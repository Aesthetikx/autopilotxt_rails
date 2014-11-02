class Message < ActiveRecord::Base
  validates :body, length: { in: 1..350 }
  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :source, presence: true
  validates :time, presence: true

  belongs_to :conversation
end
