class FarmsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :products_list ]
  include ZipCodeHelper

  def index
    @categories = Category.all

    @zip_code = get_zip_code_number

    @url_data = {"Postal_Code" => @zip_code.to_i}.to_json

    @headers = {
      "X-Parse-Application-Id" => ENV['ZIP_CODE_CONVERTER_APPLICATION_ID'],
      "X-Parse-REST-API-Key" => ENV['ZIP_CODE_CONVERTER_API_KEY']
    }

    # HTTP CALL TO GET THE LAT LNG FROM A ZIP CODE
    @response = HTTParty.get("https://parseapi.back4app.com/classes/SwitzerlandZipCodes_Switzerland_Zip_Code?limit=1&keys=Postal_Code,Latitude,Longitude&where=#{@url_data}",
      headers:    @headers
    )

    unless @response["results"].empty?
      latitude = @response["results"][0]["Latitude"]
      longitude = @response["results"][0]["Longitude"]
      @farms     = Farm.near([latitude, longitude], 200000, units: :km)
    else
      @farms = Farm.all
    end

    @far_farms = Farm.none


    if @zip_code.present?
      @far_farms = @farms.where.not("regions && ARRAY[?] ", @zip_code)
      @farms     = @farms.where("regions && ARRAY[?] ", @zip_code)
    end

    @category = Category.find_by(name: params[:category])
    if @category.present?
      @far_farms = @far_farms.joins(:categories).where(categories: { name:  @category.name })
      @farms     = @farms.joins(:categories).where(categories: { name: @category.name })
    end

    @label = params[:labels]
    if @label.present?
      @far_farms = @far_farms.where("labels && ARRAY[?] ", @label)
      @farms     = @farms.where("labels && ARRAY[?]", @label)
    end

    @delivery = params[:farms]
    if @delivery.present?
      if @delivery == "retrait à l’exploitation"
        @far_farms = @far_farms.where(accepts_take_away: true)
        @farms     = @farms.where(accepts_take_away: true)
      elsif @delivery == "Distribution régionale" || "Expédition nationale"
        @far_farms = @far_farms.where(accepts_delivery: true)
        @farms     = @farms.where(accepts_delivery: true)
      end
    end

    @farms = policy_scope(@farms).active
    @far_farms = policy_scope(@far_farms).active

    @nearby_markers = @farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url('icons/marker-purple.png')
      }
    end

    @far_markers = @far_farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url('icons/marker-orange.png')
      }
    end
    if params["category"].nil? && params["labels"].nil?
      $tracker.track(session[:mixpanel_id], 'Search Farms', {
        'Zip Code' => get_zip_code_number,
        'Results Count' => @farms.size + @far_farms.size
      })
    else
      mixpanel_params = {
        'Zip Code' => get_zip_code_number,
        'Results Count' => @farms.size + @far_farms.size
      }
      mixpanel_params["Labels Name"] = params["labels"] if params["labels"].present?
      mixpanel_params["Categories Name"] = params["category"] if params["category"].present?
      $tracker.track(session[:mixpanel_id], 'Refine Search Farms', mixpanel_params)
    end
  end

  def products_list
    puts "called"
    @farm = Farm.friendly.find(params[:id])
    authorize @farm
    subcategory_id = params[:subcategory_id]
    if subcategory_id.blank?
      products_list = @farm.products.available
    else
      subcategory = ProductSubcategory.find(subcategory_id)
      return if subcategory.farm != @farm
      products_list = subcategory.products.available
    end

    case params[:order]
    when "name"
      products_list = products_list.sort_by{ |e| e.name.downcase }
    when "price"
      products_list = products_list.reorder(:price_cents)
    end

    unless params[:takeaway_only].blank?
      products_list = products_list.fresh
    end

    render partial: 'shared/products_list', locals: {products: products_list}
  end

  def show
    @farm = Farm.friendly.find(params[:id])
    @reassurance = true
    @farms = Farm.all
    @far_farms = Farm.none
    @farm_show = @farms.where("farms.slug = ? ", params[:id])

    @date = Date.current + 1

    @zip_code = get_zip_code_number

    @near_farm = @farm.regions.include?(@zip_code)

    marker_icon_path = if @near_farm
      'icons/marker-purple.png'
    else
      'icons/marker-orange.png'
    end

    if @near_farm
      @products_available = @farm.products.available
    else
      @products_available_not_fresh = @farm.products.available.not_fresh
      @products_available = @farm.products.available
      @products_available_all = @farm.products.available
    end

    @markers = @farm_show.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url(marker_icon_path)
      }
    end

    authorize @farm
    mixpanel_params = {
      'Farm Name' => @farm.name,
      'Farm Labels' => @farm.labels,
      'Farm Categories' => @farm.categories.pluck(:name),
      'Retrait A La Ferme?' => @farm.accepts_take_away
    }
    if @farm.accepts_delivery
      if @farm.is_in_close_zone?(get_zip_code_number)
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
    $tracker.track(session[:mixpanel_id], 'Show Farm', mixpanel_params)
  end

  private

  def farm_params
    params.require(:farm).permit(:name, :description, :address, :lagitude, :longitude, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accepts_delivery,  photos: [], labels: [])
  end
end
