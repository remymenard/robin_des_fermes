# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order_confirmation_customer
    user = User.first
    order = FarmOrder.first
    OrderMailer.order_confirmation_customer(user, order)
  end

  def order_confirmation_owner
    user = User.first
    order = FarmOrder.first
    owner = User.last
    OrderMailer.order_confirmation_owner(user, order, owner)
  end
end
