class ItemValue<ApplicationRecord
    belongs_to :item
    belongs_to :field
    validates :value,presence:true
end