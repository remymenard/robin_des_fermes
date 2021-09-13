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

    authorize @product
  end

  def open_modal
    skip_authorization
    @product = Product.find(params[:id])
    mixpanel_params = {
      'Product Name' => @product.name,
      'Farm Name' => @product.farm.name,
      'Product Category' => @product.category.name,
      'Product Labels' => @product.label,
      'Product Weight' => @product.total_weight + @product.unit,
      'Product Fresh' => @product.fresh,
      'Retrait A La Ferme?' => @product.farm.accepts_take_away
    }
    if @product.farm.accepts_delivery
      if @product.farm.is_in_close_zone?(get_zip_code_number) &&
        mixpanel_params["Distrubution Régionale?"] = true
        mixpanel_params["Expédition Nationale?"] = false
      else
        mixpanel_params["Distrubution Régionale?"] = false
        mixpanel_params["Expédition Nationale?"] = true
      end
    else
      mixpanel_params["Distrubution Régionale?"] = false
      mixpanel_params["Expédition Nationale?"] = false
    end
    mixpanel_params["Expédition Nationale?"] = false if @product.fresh
    $tracker.track(session[:mixpanel_id], 'Show Product', mixpanel_params)
  end

end
