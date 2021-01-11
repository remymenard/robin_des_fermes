module Basket
  class AddProductService
    def initialize(product_id, current_user, cookie)
      @product_id = product_id
      @current_user = current_user
      @cookie = cookie
    end

    def call
      create_order if order_id.nil?
      OrderLineItem.create!(order: order_id, product_id: @product_id)
      order_id
    end

    private
    def order_id
      if @current_user
        Order.find_by(buyer: @current_user)
      else
        @cookie ? Order.find_by(id: @cookie) : nil
      end
    end

    def create_order
      if @current_user
        Order.create!(buyer: @current_user)
      else
        order = Order.create
        order
      end
    end
  end
end
