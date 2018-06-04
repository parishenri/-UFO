class ConversationsController < ApplicationController

  def index
    @sent_conversations = Conversation.where(sender_id: current_user.id)
    @recieved_conversations = Conversation.where(receiver_id: current_user.id)
    #@messages = Message.where(conversation_id: conversation.id)
  end

  def create

  end

end
