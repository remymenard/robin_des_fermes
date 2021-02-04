class FarmOrder < ApplicationRecord
  belongs_to :order
  belongs_to :farm

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
end
