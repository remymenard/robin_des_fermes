class OrdersController < ApplicationController
  before_action :verify_order_owner

  def show
  end

  def review
  end

  def delivery
  end

  def update_delivery_methods
    @zip_code = current_user.zip_code

    params[:farm_orders].each do |farm_order_id, user_choice|
      user_delivery_choice = user_choice["user_shipping_choice"]

      farm_order = current_order.farm_orders.find(farm_order_id)
      farm_order.update_delivery_choice(user_delivery_choice)
    end

    # Prevent users from editing the page to remove inputs and not pay shipping costs
    @order.farm_orders.each do |farm_order|
      return throw_error unless farm_order.ready_for_payment?
    end

    @order.update(status: 'waiting')

    Datatrans::CreateTransactionService.new(
      @order,
      payment_redirection_urls
    ).call

    @transaction_id = @order.transaction_id

    authorize @order
    render json: {transaction: @transaction_id.to_s }
  end

  private
  def verify_order_owner
    @order = Order.find(params[:id])
    authorize @order
  end

  def payment_redirection_urls
    {
      successUrl: successful_orders_redirect_payments_url,
      cancelUrl:  canceled_orders_redirect_payments_url,
      errorUrl:   with_error_orders_redirect_payments_url
    }
  end

  def throw_error
    render json: { transaction: 'error' }, status: 400
  end
end
