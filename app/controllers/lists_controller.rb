class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [ :show, :destroy, :update ]
  def index
    @lists = current_user.lists
  end

  def show
    @marker = Marker.new
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated.", status: :see_other
    else
      render :show, status: :unprocessable_content
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = current_user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
