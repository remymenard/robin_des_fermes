class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    cookies.permanent[:user_id] = current_user.id

    if cookies[:order_id]
      Order.find_by(id: cookies[:order_id]).update buyer: current_user
    end

    stored_location_for(:user) || super
  end

  def after_sign_out_path_for(resource_or_scope)
    if cookies[:user_id]
      cookies.permanent[:order_id] = Order.find_by(buyer_id: cookies[:user_id])&.id
    end

    request.referrer || super
  end
end
