module Orders
  module Redirect
    class PaymentsController < ApplicationController
      before_action :set_order

      def successful
      end

      def canceled
      end

      def with_error
        @order.update(status: 'failed')
      end

      private

      def set_order
        @order = Order.find_by(transaction_id: params["datatransTrxId"])
      end
    end
  end
end
