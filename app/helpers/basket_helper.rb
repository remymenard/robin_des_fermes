module BasketHelper
  def current_order_items_count
    if current_order_available?
      current_order.order_line_items.sum(:quantity)
    else
      0
    end
  end

  def current_order_available?
    !!current_order
  end

  def current_order
    # Si t'es logged in
      # Chope le dernier order en date non status "paid"
      # Si pas d'order -> créé un appartenant à ce user
    # Si t'es pas logged in
      # Si y'a un order_id dans tes cookies, on load cet order
        # À vérifier que c'est ce qu'on veut faire
          # Est-ce que c'est pas limite de donner accès à l'order d'un user à qqn de pas connecté ?
      # Sinon
        # renvoie nil
    if user_signed_in?
      order = current_user.orders.waiting.order(created_at: :desc).first

      if order.nil?
         return create_order_for_current_user
      end
      order
    else
      Order.waiting.find_by(id: cookies[:order_id]) || create_order_for_guest
    end
  end

  private

  def create_order_for_current_user
    order = Order.create!(buyer: current_user)
    cookies.permanent[:order_id] = order.id

    return order
  end

  def create_order_for_guest
    order = Order.create!
    cookies.permanent[:order_id] = order.id

    return order
  end
end
