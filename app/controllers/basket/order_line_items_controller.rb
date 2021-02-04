module Basket
  class OrderLineItemsController < ApplicationController
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
          @farm_order = FarmOrder.find_or_create_by(status: 'waiting', order: @order, farm: @product.farm)
          @item_in_basket = OrderLineItem.create(product: @product, order: @order, farm_order: @farm_order)
        end

        @order.compute_total_price
        @order.save

        @farm_order.compute_total_price
        @farm_order.save

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
        @order.compute_total_price
        @order.save

        @farm_order.compute_total_price
        @farm_order.save

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

        @farm_order = @item_in_basket.farm_order
        @item_in_basket.destroy
        @farm_order.destroy if @farm_order.order_line_items.empty?

        @order.compute_total_price
        @order.save

        @farm_order.compute_total_price
        @farm_order.save

        render partial: 'shared/basket'
      end
    end
  end
end
