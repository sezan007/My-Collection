class CollectionsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]   
  before_action :set_collection, only:[:show,:update,:destroy,:edit]

  def index
    @collections=Collection.all
  end

  def show
  
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
  def new
    @collection = Collection.new
  end
  def create
  
    @collection=Collection.new(collection_params)
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
      render :edit , status: :unprocessable_entity
    end

  end

  def edit
    
    
  end


  def destroy
    # binding.b
    
    @collection.destroy
    redirect_to collections_path
  
  end

  private
  def collection_params
    params.require(:collection).permit(:name,:description)
  end
  def set_collection
    @collection=Collection.find(params[:id])
  end
  



end
