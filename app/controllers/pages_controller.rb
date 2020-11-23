class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def payment
    auth = {username: '1100006818', password: 'iMNX0PIyaAXf5WC0'}

    puts response = HTTParty.post("https://api.sandbox.datatrans.com/v1/transactions",
      basic_auth: auth,
      headers: {'Content-Type' => 'application/json', 'charset' => 'UTF-8'},
      body: {
        'currency' => 'CHF',
        'refno' => 'cK1lO9XLv',
        'amount' => 1337,
        'redirect' => {
            'successUrl' => 'https://pay.sandbox.datatrans.com/upp/merchant/successPage.jsp',
            'cancelUrl' => 'https://pay.sandbox.datatrans.com/upp/merchant/cancelPage.jsp',
            'errorUrl' => 'https://pay.sandbox.datatrans.com/upp/merchant/errorPage.jsp'
        }
    }.to_json
    )
  end
end
