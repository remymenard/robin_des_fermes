class ProductSubcategory < ApplicationRecord
  belongs_to :farm
  has_many :products
end
