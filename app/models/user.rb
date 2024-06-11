class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :trackable
    
    self.table_name = 'users'
    enum role: [:user, :admin]
    def active_for_authentication?
      super && status != 'blocked'
    end
    after_initialize :set_default_role,:if => :new_record?
    def set_default_role
        self.role ||= :user
    end
    validates :name, presence: true
    has_many :collections,dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_items ,through: :likes,source: :item
    has_many :comments
    has_many :tickets
    has_secure_token :api_token
  end
  