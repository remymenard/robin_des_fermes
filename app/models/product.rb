class Product < ApplicationRecord
  belongs_to :farm
  belongs_to :category

  has_one_attached :photo

  LABELS = ['bio']

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true
  validates :label, presence: true
  validates :unit_price, presence: true
  validates :kg_price, presence: true
  validates :unit, presence: true
end
