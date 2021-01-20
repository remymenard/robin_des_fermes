module Basket
  class OrderLineItemsController < ApplicationController
    include BasketHelper
    skip_before_action :authenticate_user!

    def increment
      @product = Product.find params["id"]
      @order   = current_order

      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)

      if @product && @order

        if @item_in_basket
          @item_in_basket.increment_quantity
          @item_in_basket.save
        else
          @item_in_basket = OrderLineItem.create(product: @product, order: @order)
        end

        @order.compute_total_price
        @order.save

        authorize @item_in_basket
        render partial: 'shared/basket'
      else
        head(:bad_request)
      end
    end

    def decrement
      @product = Product.find params["id"]
      @order   = current_order

      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)

      authorize @item_in_basket

      if @product && @order
        @item_in_basket.decrement_quantity
        @item_in_basket.save

        render partial: 'shared/basket'
      else
        head(:bad_request)
      end
    end

    def destroy
      @order          = current_order
      @item_in_basket = OrderLineItem.find params["id"]

      if @item_in_basket.order == @order
        authorize @item_in_basket

        @item_in_basket.destroy

        render partial: 'shared/basket'
      end
    end
  end
end
