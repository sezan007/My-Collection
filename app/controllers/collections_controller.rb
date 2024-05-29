class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_collection, only: [:show, :update, :destroy, :edit]

  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
    @items = @collection.items.includes(:item_values)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      redirect_to @collection
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # binding.b
    if @collection.update(collection_params)
      redirect_to @collection
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description,:category, fields_attributes: [:id, :name, :field_type, :_destroy])
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
