class ProductsController < ApplicationController
  include ZipCodeHelper

  skip_before_action :authenticate_user!

  def show
    @product = Product.find(params[:id])
    @farm    = @product.farm

    @date = Date.current

    @zip_code = get_zip_code_number

    if @farm.regions.include?(@zip_code)
      @near_farm = true
    end
  end
end
