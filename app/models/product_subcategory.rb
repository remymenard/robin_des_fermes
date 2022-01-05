class ProductSubcategory < ApplicationRecord
  has_many :farms
  belongs_to :product, optional: true
end
