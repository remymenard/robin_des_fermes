module Orders
  module Redirect
    class PaymentsController < ApplicationController
      before_action :set_order

      def successful
        unless ENV['DATATRANS_ENV'] == 'production'
          order = Order.find_by(transaction_id: params["datatransTrxId"])

          unless order.nil?
            if order.status == "waiting"
              order.update(status: 'paid')
              $tracker.track(session[:mixpanel_id], 'Payment Made', {
                'Order Price' => order.price_cents / 100,
                'Order Price Currency' => order.price_currency,
                'Order Farms Name' => order.farms.pluck(:name),
              })
              $tracker.people.increment(session[:mixpanel_id], {
                'Orders Count' => 1,
              });
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
        $tracker.track(session[:mixpanel_id], 'Payment Error', {
          'Order Price' => @order.price_cents / 100,
          'Order Price Currency' => @order.price_currency,
          'Order Farms Name' => @order.farms.pluck(:name),
        })
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
