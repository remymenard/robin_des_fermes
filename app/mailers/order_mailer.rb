class OrderMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

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

  def delivery_reminder_owner
    mail(to: @user.email, subject: "Avez-vous expédié la commande n°#{@order.id} ?")
  end

  def takeaway_reminder_owner
    mail(to: @owner.email, subject: "Avez vous préparé la commande n°#{@order.id} ?")
  end

  private
  def define_order_and_user
    @order = params[:order]
    @user = params[:user]
    @owner = @order.farm.user
  end
end
