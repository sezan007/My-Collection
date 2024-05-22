class FieldsController < ApplicationController
    def new
      @collection = Collection.find(params[:collection_id])
      @field = @collection.fields.build
      render turbo_stream: turbo_stream.replace(
        :fields,
        partial: 'fields/field_fields',
        locals: { form: @field }
      )
    end
    
  end
  