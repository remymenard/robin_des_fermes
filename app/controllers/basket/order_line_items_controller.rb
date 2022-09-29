module Basket
  class OrderLineItemsController < ApplicationController
    skip_before_action :authenticate_user!

    def increment
      @product = Product.find params["id"]
      @order   = current_order
      qty = params["qty"].to_i
  
      @item_in_basket = OrderLineItem.find_by(order: @order, product: @product)

      if @product && @order

        @farm_order = FarmOrder.find_or_create_by(status: 'waiting', order: @order, farm: @product.farm)
        if @item_in_basket
          @item_in_basket.increment_quantity(qty)
          @item_in_basket.save
          $tracker.track(session[:mixpanel_id], 'Change Product Quantity In Basket', {
            'Product Name' => @product.name,
            'Product Quantity' => @item_in_basket.quantity,
            'Product Category' => @product.category.name,
            'Product Labels' => @product.label,
            'Product Weight' => @product.total_weight + @product.unit,
            'Product Fresh' => @product.fresh,
            'Product Farm Name' => @product.farm.name
          })
        else
          @item_in_basket = OrderLineItem.create(product: @product, order: @order, farm_order: @farm_order, quantity: qty)
          $tracker.track(session[:mixpanel_id], 'Add Product In Basket', {
            'Product Name' => @product.name,
            'Product Quantity' => qty,
            'Product Category' => @product.category.name,
            'Product Labels' => @product.label,
            'Product Weight' => @product.total_weight + @product.unit,
            'Product Fresh' => @product.fresh,
            'Product Farm Name' => @product.farm.name
          })
        end

        @order.compute_total_price

        @farm_order.compute_total_price

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

        @farm_order = @item_in_basket.farm_order
        @farm_order.compute_total_price

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

        @order.compute_total_price
        @farm_order.compute_total_price

        @farm_order.destroy if @farm_order.order_line_items.empty?



        render partial: 'shared/basket'
      end
    end

    def basket_modal
      sleep 0.1 # we need a small waiting time: the order line item must be persisted in the DB
      @last_added = OrderLineItem.find_by(order_id: current_order.id, product_id: params[:id])
      authorize @last_added
      render partial: 'shared/basket_modal_popup', locals: {quantity: params["qty"].to_i}
    end

  end
end
