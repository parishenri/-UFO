class MessagesController < ApplicationController

  def index
    @message = Message.new
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
    current_user.received_messages.each do |message|
      message.read = true
      message.save
    end
  end

  def create
    @message = Message.new(params_message)
    @conversation = Conversation.find(params[:conversation_id])
    @message.conversation = @conversation
    message_receiver = [@conversation.sender, @conversation.receiver] - [current_user]
    @message.user = current_user
    @message.sender = current_user
    @message.receiver = message_receiver.first
    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@message.conversation.id) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'messages/index' }
        format.js  # <-- idem
      end
    end
  end


  private

  def params_message
    params.require(:message).permit(:content, :user_id)
  end

end
