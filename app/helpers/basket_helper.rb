module BasketHelper
  def products_list
    create_order if order_id.nil?
    products_in_basket = OrderLineItem.where(order_id: order_id).order("created_at DESC")
    render partial: 'shared/basket/product', locals: { products: products_in_basket}
  end

  private
    def order_id
      if user_signed_in?
        Order.find_by(buyer: current_user)
      else
        cookies[:order_id] ? Order.find_by(id: cookies[:order_id]) : nil
      end
    end

    def create_order
      if @current_user
        Order.create!(buyer: @current_user)
      else
        order = Order.create!
        cookies.permanent[:order_id] = order.id
        order
      end
    end
end
