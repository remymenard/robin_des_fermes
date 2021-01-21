class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :order_line_items, dependent: :destroy

  monetize :price_cents, allow_nil: false,
  numericality: {
    greater_than_or_equal_to: 0,
  }

  validates :status, inclusion: { in: ["paid", "waiting"] }

  DATATRANS_TRANSACTION_ORDER_STATUSES_MAPPING = {
    # status datatrans transaction => status order

    'settled'                      => 'paid',
    ''                             => 'waiting'
  }

  scope :waiting, -> { where(status: :waiting) }

  def compute_total_price
    self.price = order_line_items.sum { |order_line_item| order_line_item.total_price }
  end
end
