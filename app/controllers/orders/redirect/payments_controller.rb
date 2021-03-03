module Orders
  module Redirect
    class PaymentsController < ApplicationController
      before_action :set_order

      def successful
        @reassurance = true
      end

      def canceled
        redirect_to delivery_order_path(@order, payment_canceled: true)
      end

      def with_error
        @order.update(status: 'failed')
        redirect_to delivery_order_path(@order, payment_with_errors: true)
      end

      private

      def set_order
        @order = Order.find_by(transaction_id: params["datatransTrxId"])
        authorize [:payments, @order]
      end
    end
  end
end
