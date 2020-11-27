module Webhooks
  module Datatrans
    class PaymentsController < Webhooks::BaseController
      def create
        @datatrans = DatatransService.new
        return @datatrans.permission_denied unless @datatrans.datatrans_ip? request

        order = Order.find_by(transaction_id: params["transactionId"])

        if params["status"] == "settled"
          order.update(status: "paid")
        end
      end
    end
  end
end
