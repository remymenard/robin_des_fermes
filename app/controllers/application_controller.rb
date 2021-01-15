class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  include Pundit

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # after_action :verify_authorized, except: :index, unless: [:skip_pundit?, :active_admin_controller?]
  # after_action :verify_policy_scoped, only: :index, unless: [:skip_pundit?, :active_admin_controller?]

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  private

  # def user_not_authorized
  #   flash[:alert] = I18n.t 'alerts.user_not_authorized'
  #   redirect_to(root_path)
  # end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end
end
