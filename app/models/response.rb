class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  acts_as_votable

  validates :body, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  def score
    get_upvotes.size - get_downvotes.size
  end
end
