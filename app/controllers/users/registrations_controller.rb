class Users::RegistrationsController < Devise::RegistrationsController
  before_action :remove_password_params_if_blank, only: [:update]

  def after_inactive_sign_up_path_for(resource)
    skip_authorization
    stored_location_for(:user) || super
  end

  def create
    skip_authorization

    super do
      if cookies[:order_id]
        Order.find_by(id: cookies[:order_id]).update buyer: resource
        cookies.permanent[:user_id] = resource.id
      end
      $tracker.alias(resource.id, session[:mixpanel_id])
      $tracker.track(resource.id, 'Finish Signup', {
        '$first_name' => resource.first_name,
        '$last_name' => resource.last_name,
        '$email' => resource.email,
        '$phone' => resource.number_phone,
        'Zip Code' => resource.zip_code,
        })
    end
  end

  def edit
    skip_authorization
    @user = current_user
  end

  def update
    skip_authorization
    @user = current_user
    @user.update(user_params)
    if @user.update(user_params)
      sign_in(current_user, :bypass => true)
      redirect_to user_session_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:number_phone, :address_line_1, :zip_code, :city, :first_name, :last_name, :title, :password, :password_confirmation, :email, :wants_to_subscribe_mailing_list)
  end

  def remove_password_params_if_blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
