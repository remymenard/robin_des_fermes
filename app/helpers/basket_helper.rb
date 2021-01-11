module BasketHelper
  def get_products
    if user_signed_in?
      order = Order.find_or_create_by(buyer: current_user)
      OrderLineItem.where(order: order)
    end
  end
end
