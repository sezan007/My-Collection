class Collection < ApplicationRecord
    belongs_to :user
    has_many :fields,dependent: :destroy
    has_many :items,dependent: :destroy
    validates :name, presence:true
    validates :description, presence:true
    has_rich_text :description
    accepts_nested_attributes_for :fields, allow_destroy: true
    # broadcasts_to ->(collection)  { :mycomment_list }
    VALID_CATEGORIES = %w[Book Silverware Signs Instrument].freeze
    after_initialize :set_default_category, if: :new_record?

    private
  
    def set_default_category
      self.category ||= 'other'
    end
  
    
    validates :category, inclusion: { in: VALID_CATEGORIES }

    validates :category, uniqueness: { scope: :user_id, message: "You can only create one collection per category." }
end
