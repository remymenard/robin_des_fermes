class ApplicationController < ActionController::Base

  include BasketHelper

  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  include Pundit
  include Mixpanel

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :setup_mixpanel

  after_action :verify_authorized, except: :index, unless: [:skip_pundit?, :active_admin_controller?]
  after_action :verify_policy_scoped, only: :index, unless: [:skip_pundit?, :active_admin_controller?]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Postmark::InactiveRecipientError, with: :reactivate_and_retry

  http_basic_authenticate_with name: "rdf_admin", password: "rdf_rdf_2020" if Rails.env.staging?

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale, host: ENV["DOMAIN"] || "localhost:3000", protocol: "https"}
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:number_phone, :first_name, :last_name, :address_line_1, :address_line_2, :city, :zip_code, :title, :password, :email, :password_confirmation, :wants_to_subscribe_mailing_list ])
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t 'alerts.user_not_authorized'
    redirect_to(root_path)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? && controller_name != "delivery_infos"
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end

  def authenticate_admin_user
    raise SecurityError unless current_user.try(:admin?)
  end
  rescue_from SecurityError do |exception|
    redirect_to root_path
  end

  def setup_mixpanel
    if user_signed_in?
      session[:mixpanel_id] = current_user.id
    else
      session[:mixpanel_id] = SecureRandom.uuid if session[:mixpanel_id].nil?
    end
    session[:utm_source] = params[:utm_source] unless params[:utm_source].nil?
  end

  def postmark_client
    ::Postmark::ApiClient.new(ActionMailer::Base.postmark_settings[:api_token],
                              ActionMailer::Base.postmark_settings.except(:api_token))
  end

  def reactivate_and_retry(error)
    Rails.logger.info("Error when sending #{message} to #{error.recipients.join(', ')}")
    Rails.logger.info(error)

    error.recipients.each do |recipient|
      bounce = postmark_client.bounces(emailFilter: recipient).first
      next unless bounce
      postmark_client.activate_bounce(bounce[:id])
    end

    # Try again immediately
    message.deliver
  end
end
