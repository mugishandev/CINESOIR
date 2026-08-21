class MessagesController < ApplicationController
  SYSTEM_PROMPT = "Tu es un expert en cinéma et un excellent moteur de recommandations de films. Ta mission est de recommander à l'utilisateur des films qu'il a de fortes chances d'aimer, en te basant avant tout sur ses goûts réels, ses demandes actuelles et le contexte de la conversation.
  Tu ne cherches pas simplement des films 'similaires' : tu cherches les films qui correspondent le mieux à ce que l'utilisateur veut ressentir ou regarder maintenant."

  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
