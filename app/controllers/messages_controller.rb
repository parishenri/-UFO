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
