class FarmsController < ApplicationController
  def index
    @farms = Farm.all

    @categories = Category.all

    @zip_code = '1200'

    if params[:category].present?

      if @zip_code.present?
        @farms = Farm.joins(:categories).where("categories.name = ? AND regions && ARRAY[?] ", params[:category], @zip_code)
        @far_farms = Farm.joins(:categories).where("categories.name = ? AND  NOT regions && ARRAY[?]", params[:category], @zip_code)
      else
        category = Category.find_by(name: params[:category])
        @farms = category.farms
      end

    elsif @zip_code.present?
      @farms = Farm.where("regions && ARRAY[?] ", @zip_code)
      @far_farms = Farm.where.not("regions && ARRAY[?] ", @zip_code)
    else
      @farms = Farm.all
    end

    @nearby_markers = @farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url('icons/map_marker_green')
      }
    end

    @far_markers = @far_farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url('icons/map_marker_red')
      }
    end
  end

  def show
    @farm = Farm.find(params[:id])
    @highlighted_photo = @farm.photos.first
    @second_photo      = @farm.photos[1]
    @third_photo       = @farm.photos[2]
    @fourth_photo      = @farm.photos[3]
    @conquest_photo    = @farm.photos[4]

    @date = Date.today

    @code_postal = '1200'

    if @farm.regions.include?(@code_postale)
      @near_farm = true
    end
  end

  private

  def article_params
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels)
  end
end
