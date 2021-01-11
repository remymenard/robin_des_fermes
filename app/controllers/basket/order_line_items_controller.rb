module Basket
  class OrderLineItemsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @id = params["product-id"]
      @product = Product.find(@id)
      render partial: 'shared/basket/product', locals: { product: @product}
    end
  end
end
