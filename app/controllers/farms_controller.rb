class FarmsController < ApplicationController
  def index
    @farms = Farm.all

    @categories = Category.all

    @code_postal = '1200'

    if params[:category].present?

      if @code_postal.present?
        @farms = Farm.joins(:categories).where("categories.name = ? AND regions && ARRAY[?] ", params[:category], @code_postal)
      else
        category = Category.find_by(name: params[:category])
        @farms = category.farms
      end

    elsif @code_postal.present?
      @farms = Farm.where("regions && ARRAY[?] ", @code_postal)
      @far_farms = Farm.where.not("regions && ARRAY[?] ", @code_postal)
    else
      @farms = Farm.all
    end

    @markers = @farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm }),
        image_url: helpers.asset_url('icons/map_marker_green')
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
