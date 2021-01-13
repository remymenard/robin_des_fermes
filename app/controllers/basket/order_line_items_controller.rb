module Basket
  class OrderLineItemsController < ApplicationController
    include BasketHelper
    skip_before_action :authenticate_user!

    def increment
      create_order if order_id.nil?
      @product = Product.find params["id"]
      @order = order_id
      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)
      authorize @item_in_basket
      if @product && @order
        @item_in_basket ? @item_in_basket.increment(:quantity).save : OrderLineItem.create(product: @product, order: @order)
        render partial: 'shared/basket'
      else
        head(:bad_request)
      end
    end

    def decrement
      @product = Product.find params["id"]
      @order = order_id
      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)
      authorize @item_in_basket
      unless @item_in_basket.nil?
        @item_in_basket.decrement(:quantity).save unless @item_in_basket.quantity <= 1
        render partial: 'shared/basket'
      else
        head(:bad_request)
      end
    end

    def destroy
      @order = order_id
      @item_in_basket = OrderLineItem.find params["id"]
      authorize @item_in_basket
      if @item_in_basket.order == @order
        @item_in_basket.destroy
        render partial: 'shared/basket'
      end
    end
  end
end
