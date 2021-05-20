class SendOrderConfirmationMailsJob < ApplicationJob
  queue_as :default

  def perform(farm_order)
    mailer = OrderMailer.with({user: farm_order.order.buyer, order: farm_order})

    if farm_order.status == 'in_preparation' && farm_order.takeaway_at_farm
      mailer.takeaway_confirmation_customer.deliver_now
      mailer.takeaway_confirmation_owner.deliver_now
    elsif farm_order.status == 'in_preparation' && (farm_order.standard_shipping || farm_order.express_shipping)
      mailer.delivery_confirmation_customer.deliver_now
      mailer.delivery_confirmation_owner.deliver_now
    elsif farm_order.status == 'preordered' && farm_order.takeaway_at_farm
      mailer.takeaway_preorder_customer.deliver_now
      mailer.takeaway_preorder_owner.deliver_now
    elsif farm_order.status == 'preordered' && (farm_order.standard_shipping || farm_order.express_shipping)
      mailer.delivery_preorder_customer.deliver_now
      mailer.delivery_preorder_owner.deliver_now
    end
  end
end
