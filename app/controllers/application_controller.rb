class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  http_basic_authenticate_with name: "rdf_admin", password: "rdf_rdf_2020" if Rails.env.staging?

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address_line_1, :address_line_2, :city, :zip_code, :title, :password, :email, :password_confirmation, :wants_to_subscribe_mailing_list ])
  end
end
