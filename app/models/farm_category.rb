class FarmCategory < ApplicationRecord
  belongs_to :farm
  belongs_to :category
end
