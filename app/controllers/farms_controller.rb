class FarmsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  include ZipCodeHelper

  def index
    @categories = Category.all

    @farms     = Farm.all
    @far_farms = Farm.none

    @zip_code = get_zip_code_number

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
  end

  def show
    @reassurance = true
    @farms = Farm.all
    @far_farms = Farm.none
    @farm = Farm.find(params[:id])

    @farm_show = @farms.where("farms.id = ? ", params[:id])

    @highlighted_photo = @farm.photos.first
    @second_photo      = @farm.photos[1]
    @third_photo       = @farm.photos[2]
    @fourth_photo      = @farm.photos[3]
    @conquest_photo    = @farm.photos[4]

    @date = Date.current

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
  end

  private

  def farm_params
    params.require(:farm).permit(:name, :description, :address, :lagitude, :longitude, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accepts_delivery,  photos: [], labels: [])
  end
end
