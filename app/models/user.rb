class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :groups, through: :members
         has_many :members
         has_many :messages
         has_many :events
         has_many :comments
         has_many :cards
         has_one  :personal
         accepts_nested_attributes_for :personal
         belongs_to :phone
         has_one :address
         accepts_nested_attributes_for :address
end
