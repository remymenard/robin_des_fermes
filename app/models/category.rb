class Category < ApplicationRecord
  has_many :farm_categories
  has_many :farms, through: :farm_categories
  has_many :products, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true
end
