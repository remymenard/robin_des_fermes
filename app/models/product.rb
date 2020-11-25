class Product < ApplicationRecord
  belongs_to :farm
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true
  validates :label, presence: true
  validates :unit_price, presence: true
end
