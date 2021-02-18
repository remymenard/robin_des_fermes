class SendOrderConfirmationMailsJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.farm_orders.each do |farm_order|
      mailer = OrderMailer.with({user: order.buyer, order: farm_order})

      if farm_order.status == 'waiting_shipping' && farm_order.takeaway_at_farm
        mailer.takeaway_confirmation_customer.deliver_now
        mailer.takeaway_confirmation_owner.deliver_now
      elsif farm_order.status == 'waiting_shipping' && (farm_order.standard_shipping || farm_order.express_shipping)
        mailer.delivery_confirmation_customer.deliver_now
        mailer.delivery_confirmation_owner.deliver_now
      elsif farm_order.status == 'preordered' && farm_order.takeaway_at_farm
        mailer.takeaway_preorder_customer.deliver_now
        mailer.takeaway_preorder_owner.deliver_now
      end
    end
  end
end
