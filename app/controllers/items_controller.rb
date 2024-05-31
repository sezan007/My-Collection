class ItemsController < ApplicationController
  def show
    @collection=Collection.find(params[:collection_id])
    # @item = @collection.items.find(params[:id])
    @item=@collection.items.find(params[:id])
    # binding.b
    @toggle_theme = current_user.light_theme
  end
  def edit
    # binding.b
    @collection=Collection.find(params[:collection_id])
    @item = @collection.items.find(params[:id])
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
  def destroy
    @collection=Collection.find(params[:collection_id])
    @item = @collection.items.find(params[:id])
    @item.destroy
    redirect_to collection_path(@collection),notice: "Item Deleted  !"
    
  end

  def update
    @collection=Collection.find(params[:collection_id])
    @item = @collection.items.find(params[:id])
    # Rails.logger.debug "Parameters: #{params.inspect}"
    # binding.b
    Rails.logger.debug "Parameters: #{params.inspect}"
    if @item.update(item_params)
      tags_input = params[:item][:tags][0].to_s
      tags_array = tags_input.split(',').map(&:strip)
      # binding.b
      @item.tags = tags_array
      if @item.save
        redirect_to collection_path(@collection.id), notice: 'Item was successfully updated.'
      else
        render :edit, notice: 'Tag was not saved updated.'
      end
      
    else
      render :edit, notice: 'something went wrong'
    end
    # binding.b
  end
  # private
  def item_params
    params.require(:item).permit(:name, tags: [],item_values_attributes: [:id,:field_id,:value] )
    # params.require(:item).permit(:name, :tags, item_values_attributes: [:field_id, :value])
  end
end
