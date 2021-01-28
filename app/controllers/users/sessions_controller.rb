class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    session[:user_id] = current_user.id
    if session[:order_id]
      Order.find_by(id: session[:order_id]).update buyer: current_user
    end

    stored_location_for(:user) || super
  end

  def after_sign_out_path_for(resource_or_scope)
    if session[:user_id]
      session[:order_id] = Order.find_by(buyer_id: session[:user_id])&.id
    end

    request.referrer || super
  end
end
