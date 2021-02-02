class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource_or_scope)
    cookies.permanent[:user_id] = current_user.id
    if cookies[:order_id]
      Order.find_by(id: cookies[:order_id]).update buyer: current_user
    end
    stored_location_for(:user) || super
  end

  def sign_out
    user_id = current_user.id
    cookies.permanent[:user_id] = user_id
    super
  end

  def after_sign_out_path_for(user)
    cookies.permanent[:order_id] = User.find(cookies[:user_id]).orders.waiting.order(created_at: :desc).first.id
    request.referrer || super
  end
end
