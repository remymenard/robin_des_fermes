class ProductsController < ApplicationController
  def show
    @farm = Farm.find(params[:farm_id])
    @product = Product.find(params[:id])
  end
end
