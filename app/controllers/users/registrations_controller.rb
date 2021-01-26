class Users::RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(resource)
    stored_location_for(:user) || super
  end
end
