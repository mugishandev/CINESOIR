class MarkersController < ApplicationController

  def create
    # On récupère le om d'une liste pour la créer
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:movie_id])

    @marks = Marker.new(marker_params)
    @marks.movie = @movie
    @marks.list = @list

    if @marker.save
      redirect_to markers_path
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

 def new
    @list = List.find(params[:list_id])
    @marker = Marker.new
 end
