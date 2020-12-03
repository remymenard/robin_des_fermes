class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])

    @date = Date.current

    @farm = Farm.find(params[:id])

    @code_postal = '1200'

    if @farm.regions.include?(@code_postale)
      @near_farm = true
    end
  end
end
