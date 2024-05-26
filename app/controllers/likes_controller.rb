class LikesController < ApplicationController
    before_action :authenticate_user!
    def create
        # binding.b
        @item=Item.find(params[:item_id])
        @like=@item.likes.build(user: current_user)

        if @like.save
            redirect_to collection_item_path(@item.collection, @item),notice: "Item Liked"
        else
            redirect_to collection_item_path(@item.collection, @item),notice: "Like failed"
        end
    end
    def destroy
        # binding.b
        @item=Item.find(params[:item_id])
        @like=@item.likes.find_by(user: current_user)
        if @like.destroy
            redirect_to collection_item_path(@item.collection,@item),notice: "unliked item"
        else
            redirect_to collection_item_path(@item.collection,@item),notice: "Failed to unlike item" 
        end           
    end
end
