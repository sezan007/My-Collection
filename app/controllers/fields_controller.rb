class FieldsController < ApplicationController
  before_action :set_collection

    def new
      @collection = Collection.find(params[:collection_id])
      @field = @collection.fields.build
    end
    
    def destroy
      
      binding.b
    end


    private

    def set_collection
        @collection=Collection.find(params[:collection_id])
    end
    

  end
  