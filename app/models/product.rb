class Product < ApplicationRecord
  belongs_to :farm
  belongs_to :category

  has_one_attached :photo

  validates :name, presence: true
  #validates :description, presence: true
  #validates :ingredients, presence: true
  #validates :label, presence: true
  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
  monetize :price_per_unit_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
  #validates :unit, presence: true

  scope :available, -> ()    { where(available: true) }
  scope :not_fresh, -> ()    { where(fresh: false) }
  scope :in_farm,   -> (farm) { where(farm: farm) }
end
