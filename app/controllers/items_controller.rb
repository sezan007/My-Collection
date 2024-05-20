class ItemsController < ApplicationController
  def show
  end

  def create
    
    @collection=Collection.find(params[:collection_id])
   
    @item=@collection.items.new(item_params)

    # @item.tags = params[:item][:tags][0].split(",")
 
    # binding.b
    tags_input = params[:item][:tags][0].to_s
    tags_array = tags_input.split(',').map(&:strip)
    @item.tags = tags_array
    # binding.b
    
    
    if @item.save
      # binding.b
      
      redirect_to @collection
    else
      missing_fields=@item.errors.full_messages.join(", ")
      
      redirect_to new_collection_item_path, notice: "Fields Required #{missing_fields}"
    end
  end

  def new
    @collection=Collection.find(params[:collection_id])
    @item=@collection.items.new
    @collection.fields.each do |field|
      @item.item_values.build()
    end
  end

  def edit
  end
  # private
  def item_params
    params.require(:item).permit(:name, tags: [] ,item_values_attributes: [:field_id, :value])
    # params.require(:item).permit(:name, :tags, item_values_attributes: [:field_id, :value])
  end
end
