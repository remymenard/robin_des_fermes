class Order < ApplicationRecord
  monetize :price_cents
end
