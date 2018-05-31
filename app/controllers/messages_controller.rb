class MessagesController < ApplicationController

  def index
    @message = Message.new
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end

  def create
    @message = Message.new(params_message)
    @message.conversation_id = params[:conversation_id]
    @message.user_id = current_user.id
    if @message.save
      redirect_to conversation_messages_path(@message.conversation.id)
    else
    end
  end


  private

  def params_message
    params.require(:message).permit(:content, :user_id)
  end

end
