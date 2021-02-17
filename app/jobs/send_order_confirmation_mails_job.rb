class SendOrderConfirmationMailsJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.farm_orders.each do |farm_order|
      if farm_order.status == 'waiting_shipping' && farm_order.takeaway_at_farm
        OrderMailer.takeaway_confirmation_customer(order.buyer, farm_order).deliver
        OrderMailer.takeaway_confirmation_owner(order.buyer, farm_order, farm_order.farm.user).deliver
      end
    end
  end
end
