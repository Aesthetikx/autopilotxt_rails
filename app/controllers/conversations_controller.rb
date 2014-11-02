class ConversationsController < ApplicationController
  def top
    render json: nil
  end

  def new
    @conversations = Conversation.respondable.order("created_at DESC")
    render json: @conversations
  end

  def old
    @conversations = Conversation.respondable.order("expires_at ASC")
    render json: @conversations
  end

  def hot
    render json: nil
  end
end
