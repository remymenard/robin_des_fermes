class FarmOffice < ApplicationRecord
  belongs_to :office
  belongs_to :farm

  has_many :farm_orders, dependent: :nullify

  validates :delivery_day, presence: true
  validates :delivery_deadline_day, presence: true
  validates :delivery_deadline_hour, presence: true
end
