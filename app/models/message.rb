class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :content, presence: true, unless: :image?
  mount_uploader :image, ImageUploader

end
