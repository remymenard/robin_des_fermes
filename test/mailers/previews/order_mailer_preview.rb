# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def takeaway_confirmation_customer
    set_order_mailer
    @mailer.takeaway_confirmation_customer
  end

  def takeaway_confirmation_owner
    set_order_mailer
    @mailer.takeaway_confirmation_owner
  end

  def takeaway_ready_alert_customer
    set_order_mailer
    @mailer.takeaway_ready_alert_customer
  end

  private
  def set_order_mailer
    user = User.first
    order = FarmOrder.first
    @mailer = OrderMailer.with({user: user, order: order})
  end
end
