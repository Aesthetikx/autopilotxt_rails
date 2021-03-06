class User < ActiveRecord::Base
  has_many :conversations
  has_many :responses

  acts_as_voter

  validates :username, presence: true

  def submission_score
    conversations.sent.map(&:score).reduce(:+) + conversations.size
  end

  def response_score
    responses.map(&:score).inject(:+)
  end

end
