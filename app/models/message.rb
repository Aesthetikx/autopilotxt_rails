class Message < ActiveRecord::Base
  validates :body, length: { in 1..350 }
  validates :body, prescence: true
  validates :conversation_id, prescence: true
  validates :source, prescence: true
  validates :time, prescence: true
end
