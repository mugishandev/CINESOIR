class PagesController < ApplicationController
  def home
    @lists = List.all
    @chats = Chat.all
  end
end
