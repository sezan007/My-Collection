class Field < ApplicationRecord

    belongs_to :collection
    FIELD_TYPES =%w[integer boolean string text date].freeze
    # validates :name,presence: true presence:true,
    validates :field_type, inclusion: { in: FIELD_TYPES }
    
    after_create_commit do
        broadcast_append_to :mycomment_list,target:'comments' ,partial: 'comments/comment',locals:{comment:self}
      end

end
