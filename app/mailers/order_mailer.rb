class OrderMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  before_action :define_order_and_user

  default from: "Robin des Fermes <#{ENV["DEFAULT_EMAIL"]}>"
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
end
