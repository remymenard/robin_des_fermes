class DatatransService

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

  def create_transaction(order)
    auth = {username: '1100006818', password: ENV['DATATRANS_PASSWORD']}

    response = HTTParty.post("https://api.sandbox.datatrans.com/v1/transactions",
      basic_auth: auth,
      headers: {'Content-Type' => 'application/json', 'charset' => 'UTF-8'},
      body: {
        'currency' => order.price_currency.downcase,
        'refno' => order.id,
        'amount' => order.price_cents,
        'redirect' => {
            'successUrl' => "#{ENV["NGROK_URL"]}/payment_success",
            'cancelUrl' => "#{ENV["NGROK_URL"]}/payment_cancel",
            'errorUrl' => "#{ENV["NGROK_URL"]}/payment_error"
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
    order.update(transaction_id: @transaction_id)
    @transaction_id
  end
end
