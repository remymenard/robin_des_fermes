class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :payment_post ]
  skip_before_action :verify_authenticity_token, only: [ :payment_post ]

  def home
  end

  def payment
    auth = {username: '1100006818', password: ENV['DATATRANS_PASSWORD']}

    puts response = HTTParty.post("https://api.sandbox.datatrans.com/v1/transactions",
      basic_auth: auth,
      headers: {'Content-Type' => 'application/json', 'charset' => 'UTF-8'},
      body: {
        'currency' => 'CHF',
        'refno' => 'cK1lO9XLv',
        'amount' => 1337,
        'redirect' => {
            'successUrl' => 'https://0f774e21fdea.eu.ngrok.io/',
            'cancelUrl' => 'https://pay.sandbox.datatrans.com/upp/merchant/cancelPage.jsp',
            'errorUrl' => 'https://pay.sandbox.datatrans.com/upp/merchant/errorPage.jsp',
        }
    }.to_json
    )

    @transaction_id = response["transactionId"]
    # @transaction_id = "201124094850762084"
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

  def payment_post
    return permission_denied unless datatrans_ip? request
    Order.find(params["transactionId"])
    binding.pry

  end
end
