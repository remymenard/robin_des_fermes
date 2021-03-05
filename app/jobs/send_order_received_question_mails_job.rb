class SendOrderReceivedQuestionMailsJob < ApplicationJob
  queue_as :default

  def perform(farm_order)
    if farm_order.standard_shipping || farm_order.express_shipping
      OrderMailer.with({user: farm_order.order.buyer, order: farm_order}).delivery_received_question_customer.deliver_now
      farm_order.update(status: 'received')
    else
      farm_order.update(status: 'withdrawn')
    end
  end
end
