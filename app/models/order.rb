class Order < ApplicationRecord
  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
  validates :status, inclusion: { in: ["paid", "waiting"] }
  validates :buyer_id, presence: true
  validates :seller_id, presence: true

end
