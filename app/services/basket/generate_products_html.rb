module Basket
  class GenerateProductsHtml
    def initialize(order_id)
      @order_id = order_id
    end

    def call
      products = OrderLineItem.where(order_id: @order_id)
      products.map do |product|
        render partial: 'shared/basket/product', locals: { product: product}
      end
    end
  end
end
