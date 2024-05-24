class FieldsController < ApplicationController
  before_action :set_collection
  before_action :set_field ,only: [:destroy]

    def new
      @collection = Collection.find(params[:collection_id])
      @field = @collection.fields.build
      render turbo_stream: turbo_stream.replace(
        :fields,
        partial: 'fields/field_fields',
        locals: { form: @field }
      )
    end
    
    def destroy
      
      binding.b
    end


    private

    def set_collection
        @collection=Collection.find(params[:collection_id])
    end
    
    def set_field
      @field=@collection.fields.find(params[:id])
    end

  end
  