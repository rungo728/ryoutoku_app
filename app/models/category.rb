class Category < ApplicationRecord
  has_many :events
  has_ancestry
end
