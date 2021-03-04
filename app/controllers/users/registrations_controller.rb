class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_inactive_sign_up_path_for(resource)
    skip_authorization
    stored_location_for(:user) || super
  end

  def create
    skip_authorization
    super do
      if cookies[:user_id]
        Order.find_by(id: cookies[:order_id]).update buyer: resource
        cookies.permanent[:user_id] = resource.id
      end
    end
  end

  def edit
    skip_authorization
    @user = current_user
  end

  def update
    skip_authorization
    @user = current_user
    if @user.update(configure_permitted_parameters)
      redirect_to stored_location_for(:user)
    else
      render 'edit'
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:number_phone, :address_line_1, :zip_code, :city, :first_name, :last_name, :title])
  end
end
