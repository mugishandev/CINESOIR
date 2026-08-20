class MarkersController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @marker = Marker.new
  end
  def create
    @list = List.find(params[:list_id])

    if params[:marker][:movie_id].blank?
      @marker = @list.markers.build
      @marker.errors.add(:movie, "doit être selectionné")
      render "lists/show", status: :unprocessable_entity and return
    end

    @marker = @list.markers.build(marker_params)

    if @marker.save
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
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
