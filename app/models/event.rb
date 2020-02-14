class Event < ApplicationRecord
  belongs_to :exhibitor, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :prefecture
  belongs_to :category
  has_many :messages,  dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :images,dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  #イメージをDB登録するために記載
  has_one :cook
  has_one :address
  has_many :users, through: :messages
end
