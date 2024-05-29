class Item<ApplicationRecord
    belongs_to :collection
    has_many :item_values, dependent: :destroy
    has_many :fields, through: :item_values
    has_many :likes, dependent: :destroy
    has_many :liked_by_user, through: :likes,source: :user
    has_many :comments, dependent: :destroy
    accepts_nested_attributes_for :item_values, allow_destroy: true
    validates :name,presence:true
    validate :tags_array_non_empty

    private
  
    def tags_array_non_empty
      if tags.present? && tags.all?(&:blank?)
        errors.add(:tags, "can't be empty")
      end
    end
end