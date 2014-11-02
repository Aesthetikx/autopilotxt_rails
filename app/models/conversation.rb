class Conversation < ActiveRecord::Base
  has_many :messages
  has_many :responses
  belongs_to :user

  acts_as_votable

  validates :expires_at, presence: true
  validates :user_id, presence: true

  scope :live, -> { where("expires_at > ?", Time.now) }
  scope :expired, -> { where("expires_at < ?", Time.now) }
  scope :respondable, -> { where("expires_at > ?", Time.now + 30.seconds) }
  scope :sent, -> { where(sent: true) }
  scope :unsent, -> { where(sent: false) }

  def live?
    expires_at > Time.now
  end

  def expired?
    expires_at < Time.now
  end

  def respondable?
    expires_at > (Time.now + 30.seconds)
  end

  def score
    (get_upvotes.size - get_downvotes.size) + responses.size
  end

end
