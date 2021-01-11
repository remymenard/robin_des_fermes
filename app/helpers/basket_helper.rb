module BasketHelper
  def products_list
    order_id = Basket::AddProductService.new(@id, current_user).call
    products_in_basket = OrderLineItem.where(order_id: order_id)
    products_instance = products_in_basket.map { |product_in_basket| product_in_basket.product }
  end
end
