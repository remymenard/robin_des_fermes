module Orders
  class PaymentsController < ApplicationController
    def new
      @order = Order.find(params[:order_id])
      @order.update(status: 'waiting')

      Datatrans::CreateTransactionService.new(
        @order,
        payment_redirection_urls
      ).call

      @transaction_id = @order.transaction_id

      authorize @order
    end

    private

    def payment_redirection_urls
      {
        successUrl: successful_orders_redirect_payments_url,
        cancelUrl:  canceled_orders_redirect_payments_url,
        errorUrl:   with_error_orders_redirect_payments_url
      }
    end
  end
end
