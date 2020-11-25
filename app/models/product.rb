class Product < ApplicationRecord
  belongs_to :farm
  belongs_to :category

  has_many_attached :photos

  LABELS = ['bio']

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true
  validates :label, presence: true, inclusion: { in: LABELS }
  validates :unit_price, presence: true
end
