require 'active_support/concern'

module Votable 
  extend ActiveSupport::Concern

  def upvote
    self.find(params[:id]).upvote_from current_user
  end

  def downvote
    self.find(params[:id]).downvote_from current_user
  end

  def score
    self.find(params[:id]).score
  end

end
