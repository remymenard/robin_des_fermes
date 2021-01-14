class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    cookies.permanent[:user_id] = current_user.id
    unless cookies[:order_id].nil?
      Order.find_by(id: cookies[:order_id]).update buyer: current_user
    end
    stored_location_for(resource_or_scope) || super
  end

  def after_sign_out_path_for(resource_or_scope)
    unless cookies[:user_id].nil?
      user = User.find(cookies[:user_id])
      cookies.permanent[:order_id] = Order.find_by(buyer: user).id
    end
    request.referrer || super
  end
end
