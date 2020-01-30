class Event < ApplicationRecord
  belongs_to :exhibitor, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :prefecture
  belongs_to :category
  has_many :comments
  has_many :images
end
