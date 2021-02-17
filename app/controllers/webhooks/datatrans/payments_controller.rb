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
        return permission_denied unless datatrans_valid_ip?

        # @datatrans = DatatransService.new
        order = Order.find_by(transaction_id: params["transactionId"])

        if params["status"] == "settled"
          order.update(status: 'paid')
          order.farm_orders.each do |farm_order|
            if farm_order.contains_preorder_product?
              farm_order.update(price: farm_order.total_price_with_shipping, status: 'preordered', waiting_for_preorder_at: Date.current, waiting_for_shipping_at: farm_order.compute_preorder_delivery_date)
            else
              farm_order.update(price: farm_order.total_price_with_shipping, status: 'waiting_shipping', waiting_for_shipping_at: Date.current)
              OrderMailer.order_confirmation_owner(order.buyer, farm_order, farm_order.farm.user).deliver
              OrderMailer.order_confirmation_customer(order.buyer, farm_order).deliver
            end
          end
        else
          # TODO LATER: handle non happy paths
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
