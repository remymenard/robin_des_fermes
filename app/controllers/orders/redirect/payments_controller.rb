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
                  farm_order.update(price: farm_order.total_price_with_shipping, status: 'preordered', waiting_for_preorder_at: Time.now, waiting_for_shipping_at: farm_order.compute_preorder_delivery_date, estimated_delivery_date: farm_order.delivery_date(current_user.zip_code))
                  schedule_reminder_mail(farm_order.delivery_date(current_user.zip_code) - 7.days, farm_order)
                else
                  farm_order.update(price: farm_order.total_price_with_shipping, status: 'in_preparation', waiting_for_shipping_at: Time.now, estimated_delivery_date: farm_order.delivery_date(current_user.zip_code))
                  schedule_reminder_mail(farm_order.delivery_date(current_user.zip_code) - 1.day, farm_order)
                end
              end
              SendOrderConfirmationMailsJob.perform_now(order)
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

      def schedule_reminder_mail(date, farm_order)
        date += 1.day if date.beginning_of_day == Time.now.beginning_of_day
        SendOrderReminderMailsJob.set(wait_until: date.beginning_of_day).perform_later(farm_order)
      end
    end
  end
end
