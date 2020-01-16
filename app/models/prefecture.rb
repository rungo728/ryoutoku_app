class Prefecture < ApplicationRecord
  has_many :users
  has_many :items
  has_many :personals
  has_many :addresses
end
