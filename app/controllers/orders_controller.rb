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
  end

  def update_delivery_methods
    @zip_code = current_user.zip_code

    allow_params.each do |param|
      order_id      = param[0]
      delivery_type = param[1]

      @farm_order = FarmOrder.find(order_id)

      case delivery_type
      when 'takeaway'
        if @farm_order.farm.accepts_take_away
          @farm_order.update(status: 'waiting', takeaway_at_farm: true, standard_shipping: false, express_shipping: false, shipping_price: FarmOrder::ShippingPrice.takeaway)
        else
          return throw_error
        end
      when 'delivery'
        if @farm_order.farm.accepts_delivery
          if @farm_order.farm.regions.include?(@zip_code)
            @farm_order.update(status: 'waiting', takeaway_at_farm: false, standard_shipping: false, express_shipping: true, shipping_price: FarmOrder::ShippingPrice.express)
          else
            @farm_order.update(status: 'waiting', takeaway_at_farm: false, standard_shipping: true, express_shipping: false, shipping_price: FarmOrder::ShippingPrice.standard)
          end
        else
          return throw_error
        end
      end
    end

    #not mandatory by avoid users to edit the page and remove input making him able not to pay shipping costs

    @order.farm_orders.each do |farm_order|
      if farm_order.status.nil?
        return throw_error
      end
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

  def throw_error
    render json: {transaction: 'error' }
    'error'
  end
end
