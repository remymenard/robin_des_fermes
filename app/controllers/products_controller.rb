class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @farm    = @product.farm

    @date = Date.current

    @zip_code = '1200'

    if @farm.regions.include?(@zip_code)
      @near_farm = true
    end
  end
end
