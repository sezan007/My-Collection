class Field < ApplicationRecord
    belongs_to :collection
    FIELD_TYPES =%w[integer boolean string text date].freeze
    # validates :name,presence: true presence:true,
    validates :field_type, inclusion: { in: FIELD_TYPES }

end
