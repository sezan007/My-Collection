class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  # scope :filter_by_comment, ->(content){where('content ILIKE ?',"%#{content}%")}
  after_create_commit do
    broadcast_append_to :mycomment_list,target:'comments' ,partial: 'comments/comment',locals:{comment:self}
  end
  after_update_commit do
    broadcast_replace_to :mycomment_list,target:self ,partial: 'comments/comment',locals:{comment:self}
  end
  after_destroy_commit do
    broadcast_remove_to :mycomment_list,target: self
  end

end
