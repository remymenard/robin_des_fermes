class OrderMailer < ApplicationMailer
  default from: ENV["DEFAULT_EMAIL"]
  layout 'mailer'

  def order_confirmation_customer(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Ta commande n°#{order.id} est confirmée")
  end

  def order_confirmation_owner(user, order, owner)
    @user = user
    @order = order
    @owner = owner
    mail(to: @owner.email, subject: "Félicitations tu as une nouvelle commande n°#{order.id}")
  end
end
