module Basket
  class OrderLineItemsController < ApplicationController
    include BasketHelper
    skip_before_action :authenticate_user!

    def create
      @id = params["product_id"]
      create_order if order_id.nil?
      @product = Product.find @id
      @order = order_id
      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)
      if @product && @order
        @item_in_basket ? @item_in_basket.increment(:quantity).save : OrderLineItem.create(product: @product, order: @order)
        render partial: 'shared/basket'
      else
        head(:bad_request)
      end
    end
  end
end
