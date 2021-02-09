class OrdersController < ApplicationController
  before_action :verify_order_owner, except: [:create]

  def create
    order = Order.create!(price_cents: 700, buyer: current_user, seller: User.first)
    redirect_to new_order_payment_path order

    authorize order
  end

  def show
  end

  def review
  end

  def delivery
    @shipping_prices = FarmOrder.shipping_prices
    # @order = current_order
    # @farm_orders = @order.farm_orders
  end

  def update_delivery_methods
    allow_params.each do |param|
      order_id = param[0]
      delivery_type = param[1]
      @farm_order = FarmOrder.find order_id
      case delivery_type
      when 'takeaway'
        if @farm_order.farm.accepts_take_away
          @farm_order.update(status: 'waiting', takeaway_at_farm: true, standard_shipping: false, express_shipping: false)
        else
          render json: {transaction: 'error' }
          return 'error'
        end
      when 'express'
        if @farm_order.farm.accepts_delivery
          @farm_order.update(status: 'waiting', takeaway_at_farm: false, standard_shipping: false, express_shipping: true)
        else
          render json: {transaction: 'error' }
          return 'error'
        end
      when 'standard'
        if @farm_order.farm.accepts_delivery
          @farm_order.update(status: 'waiting', takeaway_at_farm: false, standard_shipping: true, express_shipping: false)
        else
          render json: {transaction: 'error' }
          return 'error'
        end
      end
        @farm_order.update(shipping_price: FarmOrder.shipping_prices[delivery_type])
    end

    @order.update(status: 'waiting')
    @order.compute_total_price

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

  def allow_params
    params.permit(current_order.farm_orders.pluck(:id).map{ |id| id.to_s })
  end

  def payment_redirection_urls
    {
      successUrl: successful_orders_redirect_payments_url,
      cancelUrl:  canceled_orders_redirect_payments_url,
      errorUrl:   with_error_orders_redirect_payments_url
    }
  end
end
