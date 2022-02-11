class Product < ApplicationRecord
  belongs_to :farm
  belongs_to :category
  belongs_to :product_subcategory, optional: true

  has_many :farm_orders

  has_one_attached :photo
  validates_presence_of :photo

  validates :name, presence: true


  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
  monetize :price_per_unit_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  scope :available, -> ()    { where(available: true) }
  scope :not_fresh, -> ()    { where(fresh: false) }
  scope :in_farm,   -> (farm) { where(farm: farm) }
  scope :fresh, -> ()    { where(fresh: true) }
end
