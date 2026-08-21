class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @lists = current_user.lists
    @chats = current_user.chats
    # @chat = current_user.chats.last || current_user.chats.create!
    @message = Message.new
  end
end
