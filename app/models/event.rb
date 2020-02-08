class Event < ApplicationRecord
  belongs_to :exhibitor, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :prefecture
  belongs_to :category
  has_many :messages
  has_many :images
  has_one :cook
  has_one :address
  has_many :users, through: :messages
end
