class Collection < ApplicationRecord
    has_many :fields,dependent: :destroy
    has_many :items,dependent: :destroy
    validates :name, presence:true
    validates :description, presence:true
    has_rich_text :description
    accepts_nested_attributes_for :fields, allow_destroy: true
    # broadcasts_to ->(collection)  { :mycomment_list }
end
