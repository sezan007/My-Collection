class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item,only: [:create,:destroy,:edit,:update]
    before_action :set_comment, only: [:destroy,:update,:edit]


    def edit
    end
    def update
        # binding.b
        if @comment.update(comment_params)
            respond_to do |format|
            
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "Comment Updated"}
                format.json{ render json:@comment,status: :created}
            end
        else
            respond_to do |format|
            
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "Comment couldn't updated"}
                format.json{ head :no_content}
            end
        end
    end

    def create
        # binding.b
        @comment=@item.comments.build(comment_params)
        @comment.user=current_user
        if @comment.content.empty?
            redirect_to collection_item_path(@item.collection,@item),notice: "comment cant be empty"
        
        # binding.b

        elsif @comment.save
            respond_to do |format|
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "comment added"}
                format.json{ render json: @comment, status: :created}
            end
        else
            respond_to do |format|
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "comment failed added"}
                format.json{ render json: @comment, status: :created}
            end

        end
    end
    def destroy
        # binding.b
        if @comment.destroy
        
            respond_to do |format|
            
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "delete success"}
                format.json{ head :no_content}
            end
        else
            respond_to do |format|
            
                format.html{ redirect_to collection_item_path(@item.collection,@item),notice: "delete failed"}
                format.json{ render json:@comment.errors,status: :unprocessable_entity }
            end
        end
    end


    private
    
    def set_item
        @item=Item.find(params[:item_id])
    end
    def set_comment
        @comment=Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
