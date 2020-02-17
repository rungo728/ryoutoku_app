class Image < ApplicationRecord
  belongs_to :event,optional: true
  # mount_uploader :content, ImageUploader
end
