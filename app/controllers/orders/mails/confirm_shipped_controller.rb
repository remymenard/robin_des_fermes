module Orders
  module Mails
    class ConfirmShippedController < ApplicationController
      skip_before_action :authenticate_user!
      skip_before_action :verify_authenticity_token

      skip_after_action :verify_authorized
      skip_after_action :verify_policy_scoped

      def set_as_shipped
        skip_authorization
        order = FarmOrder.find_by(confirm_shipped_token: params[:order_token])
        if order.status == "in_preparation"
          order.update(status: "shipped", shipped_at: Date.current)
          redirect_to successful_orders_mails_confirm_shipped_path
        else
          redirect_to with_error_orders_mails_confirm_shipped_path
        end
      end

      def successful
        skip_authorization
      end

      def with_error
        skip_authorization
      end

    end
  end
end

