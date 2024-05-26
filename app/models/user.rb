class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :trackable
    self.table_name = 'users'
    enum role: [:user, :admin]
    after_initialize :set_default_role,:if => :new_record?
    def set_default_role
        self.role ||= :user
    end
    has_many :likes, dependent: :destroy
    has_many :liked_items ,through: :likes,source: :item



  end
  