module Basket
  class OrderLineItemsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @id = params["product-id"]
      order_id = Basket::AddProductService.new(@id, current_user, cookies[:order_id]).call
      cookies.permanent[:order_id] = order_id
      products_in_basket = OrderLineItem.where(order_id: order_id)
      products_instance = products_in_basket.map { |product_in_basket| product_in_basket.product }
      render partial: 'shared/basket/product', locals: { products: products_instance}
    end
  end
end
