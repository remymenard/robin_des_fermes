class ProductsController < ApplicationController
  include ZipCodeHelper
  def show
    @product = Product.find(params[:id])
    @farm    = @product.farm

    @date = Date.current

    @zip_code = get_zip_code_number

    if @farm.regions.include?(@zip_code)
      @near_farm = true
    end

    authorize @product
  end

end
