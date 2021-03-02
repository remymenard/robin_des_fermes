class SendOrderReminderMailsJob < ApplicationJob
  queue_as :default

  def perform(farm_order)
    puts "called 🔥"
    mailer = OrderMailer.with({user: farm_order.farm.user, order: farm_order})
    puts mailer

    if farm_order.status == 'in_preparation' && farm_order.takeaway_at_farm
      puts "takeaway✅"
      mailer.takeaway_reminder_owner.deliver_now
    elsif farm_order.status == 'in_preparation' && (farm_order.standard_shipping || farm_order.express_shipping)
      puts "delivery✅"
      mailer.delivery_reminder_owner.deliver_now
    end
  end
end
