module Webhooks
  module Datatrans
    class PaymentsController < Webhooks::BaseController
      # TODO: Add comment to help find where to get these IPs addresses
      VALID_IPS = [
        NetAddr::CIDR.create('193.16.220.0/24'),
        NetAddr::CIDR.create('91.223.186.0/24'),
        NetAddr::CIDR.create('185.253.204.0/22')
      ]

      def create
        if ENV['RAILS_ENV'] == 'production'
          return permission_denied unless datatrans_valid_ip?

          @datatrans = DatatransService.new
          order = Order.find_by(transaction_id: params["transactionId"])

          if params["status"] == "settled"
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

          # else
            # TODO LATER: handle non happy paths
          end
        end
      end

      private

      def permission_denied
        render file: Rails.root.join('public/404.html'), status: :unauthorized
      end

      def datatrans_valid_ip?
        VALID_IPS.any? { |cidr| cidr.contains?(request.remote_ip) }
      end
    end
  end
end
