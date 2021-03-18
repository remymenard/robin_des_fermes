module Orders
  module Redirect
    class PaymentsController < ApplicationController
      before_action :set_order

      def successful
        order = Order.find_by(transaction_id: params["datatransTrxId"])

        unless order.nil?
          if order.status == "waiting"
            order.update(status: 'paid')
            order.farm_orders.each do |farm_order|
              if farm_order.contains_preorder_product?
                farm_order.update(price: farm_order.total_price_with_shipping, status: 'preordered', waiting_for_preorder_at: Time.now, waiting_for_shipping_at: farm_order.compute_preorder_delivery_date)
                SendOrderReminderMailsJob.set(wait_until: farm_order.preordered_products_max_shipping_starting_at - 7.days).perform_later(farm_order)
              else
                farm_order.update(price: farm_order.total_price_with_shipping, status: 'in_preparation', waiting_for_shipping_at: Time.now)
                SendOrderReminderMailsJob.set(wait_until: farm_order.waiting_for_shipping_at + farm_order.farm.delivery_delay.days - 1.day).perform_later(farm_order)
              end
            end
            SendOrderConfirmationMailsJob.perform_now(order)
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
