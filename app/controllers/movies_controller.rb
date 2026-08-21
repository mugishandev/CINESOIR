class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @chats = @movie.chats.where(user: current_user)
  end
end
