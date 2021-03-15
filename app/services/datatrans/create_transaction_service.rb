module Datatrans
  class CreateTransactionService
    BASE_URL = ENV["RAILS_ENV"] == "production" ? "https://api.datatrans.com/v1/transactions" : "https://api.sandbox.datatrans.com/v1/transactions"

    attr_reader :order, :redirection_urls, :response

    def initialize(order, redirection_urls)
      @order            = order
      @redirection_urls = redirection_urls
    end

    def call
      @response = HTTParty.post(BASE_URL,
        basic_auth: auth,
        headers:    headers,
        body:       request_body
      )
      update_order_with_transaction_id
    end

    private

    def update_order_with_transaction_id
      @order.update(transaction_id: response["transactionId"])
    end

    def request_body
      {
        refno:    @order.id,
        currency: @order.price_currency.downcase,
        amount:   calculate_price,
        theme:    theme,
        redirect: @redirection_urls,
        language: "fr"
      }.to_json
    end

    def calculate_price
      @total_price = @order.price_cents
      @total_price += @order.farm_orders.sum {|farm_order| farm_order.shipping_price_cents}
      @total_price
    end

    def headers
      {'Content-Type' => 'application/json', 'charset' => 'UTF-8'}
    end

    def auth
      {username: ENV['DATATRANS_USERNAME'], password: ENV['DATATRANS_PASSWORD']}
    end

    def theme
      {
        name: "DT2015",
        configuration: {
          logoType:   "rectangle",
          logoSrc:    "logo-robin_des_fermes_horizontal-vert.svg",
          brandColor: "#007C50"
        }
      }
    end
  end
end
