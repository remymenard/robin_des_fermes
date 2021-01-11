class Order < ApplicationRecord
  belongs_to :buyer,  class_name: 'User'

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }
  validates :status, inclusion: { in: ["paid", "waiting"] }
  validates :buyer_id, presence: true

  DATATRANS_TRANSACTION_ORDER_STATUSES_MAPPING = {
    # status datatrans transaction => status order

    'settled'                      => 'paid',
    ''                             => 'waiting'
  }
end
