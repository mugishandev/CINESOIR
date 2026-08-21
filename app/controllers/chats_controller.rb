class ChatsController < ApplicationController

 def index
    # @chats = Chat.all
    @chats = current_user.chats
 end

  def show
    @chat = current_user.chats.find(params[:id])
    @messages = @chat.messages
    @message = Message.new
  end

  def create
    @chat = current_user.chats.build

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to root_path
      flash[:alert] = "La sauvegarde a échoué, veuillez réessayer."
    end
  end
end
