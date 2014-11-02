class User < ActiveRecord::Base
  has_many :conversations

  validates :username, presence: true
end
