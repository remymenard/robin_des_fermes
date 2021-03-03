class SendOrderReminderMailsJob < ApplicationJob
  queue_as :default

  def perform(farm_order)
    mailer = OrderMailer.with({user: farm_order.farm.user, order: farm_order})
    if (farm_order.status == 'in_preparation' || farm_order.status == 'preordered') && farm_order.takeaway_at_farm
      mailer.takeaway_reminder_owner.deliver_now
    elsif (farm_order.status == 'in_preparation' || farm_order.status == 'preordered') && (farm_order.standard_shipping || farm_order.express_shipping)
      mailer.delivery_reminder_owner.deliver_now
    end
  end
end
