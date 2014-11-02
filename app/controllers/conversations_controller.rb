class ConversationsController < ApplicationController
  def top
    @conversations = Conversation.all.sort_by(&:score).reverse
    render json: @conversations
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
    @conversations = Conversation.respondable.sort_by(&:score).reverse
    render json: @conversations
  end
end
