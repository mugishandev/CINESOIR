class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @lists = List.all
    @chats = Chat.all
  end
end
