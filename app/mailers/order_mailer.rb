class OrderMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  rescue_from Postmark::InactiveRecipientError, with: :reactivate_and_retry

  before_action :define_order_and_user

  default from: ENV["DEFAULT_EMAIL"]
  layout 'mailer'

  def takeaway_confirmation_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} est confirmée")
  end

  def takeaway_confirmation_owner
    mail(to: @owner.email, subject: "Félicitations tu as une nouvelle commande n°#{@order.id}")
  end

  def delivery_confirmation_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} est confirmée")
  end

  def delivery_confirmation_owner
    mail(to: @owner.email, subject: "Félicitations tu as une nouvelle commande n°#{@order.id}")
  end

  def takeaway_preorder_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} est confirmée")
  end

  def takeaway_preorder_owner
    mail(to: @owner.email, subject: "Félicitations tu as une nouvelle commande n°#{@order.id}")
  end

  def delivery_preorder_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} est confirmée")
  end

  def delivery_preorder_owner
    mail(to: @owner.email, subject: "Félicitations tu as une nouvelle commande n°#{@order.id}")
  end

  def delivery_sent_alert_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} a été expédiée.")
  end

  def takeaway_ready_alert_customer
    mail(to: @user.email, subject: "Ta commande n°#{@order.id} est prête pour le retrait.")
  end

  def delivery_reminder_owner
    mail(to: @owner.email, subject: "Avez-vous expédié la commande n°#{@order.id} ?")
  end

  def takeaway_reminder_owner
    mail(to: @owner.email, subject: "Avez vous préparé la commande n°#{@order.id} ?")
  end

  def delivery_received_question_customer
    mail(to: @user.email, subject: "Avez vous reçu la commande n°#{@order.id} ?")
  end

  private
  def define_order_and_user
    @order = params[:order]
    @user = params[:user]
    @owner = @order.farm.user
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
