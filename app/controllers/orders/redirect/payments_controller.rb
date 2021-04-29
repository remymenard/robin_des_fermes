module Orders
  module Redirect
    class PaymentsController < ApplicationController
      before_action :set_order

      def successful
        unless ENV['RAILS_ENV'] == 'production'
          order = Order.find_by(transaction_id: params["datatransTrxId"])

          unless order.nil?
            if order.status == "waiting"
              order.update(status: 'paid')
              order.farm_orders.each do |farm_order|
                if farm_order.contains_preorder_product?
                  farm_order.update(price: farm_order.total_price_with_shipping, status: 'preordered')
                else
                  farm_order.update(price: farm_order.total_price_with_shipping, status: 'in_preparation')
                end
              end
            end
          end

        end
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
