class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :payment_webhook ]
  skip_before_action :verify_authenticity_token, only: [ :payment_webhook ]

  def show

    @order = Order.find(params[:id])
    if @order.buyer_id != current_user.id
      flash[:alert] = "You are not authorized to view this order."
      redirect_to root_path
    end
    if @order.status == "waiting"
      auth = {username: '1100006818', password: ENV['DATATRANS_PASSWORD']}

      puts response = HTTParty.post("https://api.sandbox.datatrans.com/v1/transactions",
        basic_auth: auth,
        headers: {'Content-Type' => 'application/json', 'charset' => 'UTF-8'},
        body: {
          'currency' => @order.price_currency.downcase,
          'refno' => @order.id,
          'amount' => @order.price_cents,
          'redirect' => {
              'successUrl' => 'https://0f774e21fdea.eu.ngrok.io/payment_success',
              'cancelUrl' => 'https://0f774e21fdea.eu.ngrok.io/payment_cancel',
              'errorUrl' => 'https://0f774e21fdea.eu.ngrok.io/payment_error'
          },
          "theme": {
            "name": "DT2015",
            "configuration": {
              "brandColor": "#007C50",
            }
          }
      }.to_json
      )

      @transaction_id = response["transactionId"]
      @order.update(transaction_id: @transaction_id)
    end
  end

  def permission_denied
    render file: Rails.root.join('public/404.html'), status: :unauthorized
  end

  def datatrans_ip?(request)
    @ips = []
    @ips << NetAddr::CIDR.create('193.16.220.0/24')
    @ips << NetAddr::CIDR.create('91.223.186.0/24')
    @ips << NetAddr::CIDR.create('185.253.204.0/22')
    valid = @ips.select {|cidr| cidr.contains?(request.remote_ip) }
    !valid.empty?
   end

  def payment_webhook
    return permission_denied unless datatrans_ip? request
    order = Order.find_by(transaction_id: params["transactionId"])
    order.update(status: "paid")
  end

  def payment_success
    order = Order.find_by(transaction_id: params["datatransTrxId"])
    flash[:notice] = t 'payment.success'
    redirect_to order_path(order)
  end

  def payment_cancel
    order = Order.find_by(transaction_id: params["datatransTrxId"])
    flash[:alert] = t 'payment.cancel'
    redirect_to order_path(order)
  end

  def payment_error
    order = Order.find_by(transaction_id: params["datatransTrxId"])
    flash[:alert] = t 'payment.error'
    redirect_to order_path(order)
  end
end
