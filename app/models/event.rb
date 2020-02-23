class Event < ApplicationRecord
  belongs_to :exhibitor, class_name: "User"
  belongs_to :buyer, class_name: "User",optional: true
  belongs_to :prefecture
  belongs_to :category
  has_many :messages,  dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :images,dependent: :destroy
  has_one :cook
  has_one :address
  has_many :users, through: :messages
  has_many :users, through: :entries

  #イメージ・開催場所日時・料理工程選択をDB登録するために記載
  accepts_nested_attributes_for :images,allow_destroy: true
  accepts_nested_attributes_for :cook
  accepts_nested_attributes_for :address
  
  validates_associated :images
  validates :images, presence: true

end
