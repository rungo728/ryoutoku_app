class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 予約したイベント、現在出展中のイベント、すでに予約済のイベントの条件付きアソシエーション
  has_many :buyed_events, foreign_key: "buyer_id", class_name: "Event"
  has_many :exhibiting_events, -> { where("buyer_id is NULL") }, foreign_key: "exhibitor_id", class_name: "Event"
  has_many :reserved_events, -> { where("buyer_id is not NULL") }, foreign_key: "exhibitor_id", class_name: "Event"
  
  has_many :messages,dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :comments
  has_many :cards
  has_many :events, through: :entries
  has_many :events, through: :messages
  has_one  :personal
  accepts_nested_attributes_for :personal
  has_one :address
  accepts_nested_attributes_for :address
end
