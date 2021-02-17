class Users::RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(resource)
    stored_location_for(:user) || super
  end

  def edit
    skip_authorization
    @user = current_user

  end
  def update
    skip_authorization
    @user = current_user
    if @user.update(user_params)
      redirect_to stored_location_for(:user)
    else
      render 'edit'
    end

  end
  private
  def user_params
    params.require(:user).permit(:address_line_1, :zip_code, :city, :first_name, :last_name)
  end
end
