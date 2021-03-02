module Orders
  module Mails
    class ConfirmShippedController < ApplicationController
      skip_before_action :authenticate_user!
      skip_before_action :verify_authenticity_token

      skip_after_action :verify_authorized
      skip_after_action :verify_policy_scoped

      def set_as_shipped
        order = FarmOrder.find_by(confirm_shipped_token: params[:order_token])
        if order.status == "in_preparation"
          if order.takeaway_at_farm
            order.update(status: "ready_for_withdrawal", shipped_at: Date.current)
          else
            order.update(status: "shipped", shipped_at: Date.current)
            OrderMailer.with({user: order.order.buyer, order: order}).customer_order_sent_alert.deliver_now
          end
          redirect_to successful_orders_mails_confirm_shipped_path
        else
          redirect_to with_error_orders_mails_confirm_shipped_path
        end
      end

      def successful
      end

      def with_error
      end
    end
  end
end


