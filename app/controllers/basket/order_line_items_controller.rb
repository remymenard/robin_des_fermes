module Basket
  class OrderLineItemsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @id = params["product-id"]
      @product = Product.select(:name, :description).find(@id)
      render json: @product
    end
  end
end
