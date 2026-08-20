class MarkersController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @marker = Marker.new
  end
  def create
    # On récupère le om d'une liste pour la créer
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:marker][:movie_id])

    @marker = Marker.new(marker_params)
    @marker.movie = @movie
    @marker.list = @list

    if @marker.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @markers = Marker.find(params[:id])
    @list = @marker.list

    @marker.destroy

    redirect_to list_path(@list)
  end


  private

  def marker_params
    params.require(:marker).permit(:movie_id, :list_id)
  end
end
