class Office < ApplicationRecord
  has_many :farm_offices, dependent: :destroy
  has_many :farm
end
