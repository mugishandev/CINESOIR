class ChatsController < ApplicationController
  SYSTEM_PROMPT = "Tu es un expert en cinéma et un excellent moteur de recommandations de films. Ta mission est de recommander à l'utilisateur des films qu'il a de fortes chances d'aimer, en te basant avant tout sur ses goûts réels, ses demandes actuelles et le contexte de la conversation.
  Tu ne cherches pas simplement des films 'similaires' : tu cherches les films qui correspondent le mieux à ce que l'utilisateur veut ressentir ou regarder maintenant."

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
    @content = params[:message][:content]
    @chat = current_user.chats.build
    @chat.title = @content.truncate(30)

    if @chat.save
    @message = @chat.messages.create!(role: "user", content: @content)

      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      redirect_to chat_path(@chat)
    else
      redirect_to root_path
      flash[:alert] = "La sauvegarde a échoué, veuillez réessayer."
    end
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to root_path
  end
end
