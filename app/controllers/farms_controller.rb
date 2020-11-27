class FarmsController < ApplicationController
  require 'date'

  def index
    @farms = Farm.all

    @categories = Category.all

    #@code_postal = '1200'
    # @farms = Farm.all.select { |farm| farm.regions.include?(@code_postal) }
    #@farms = Farm.where("regions && ARRAY[?]", @code_postal)

    if params[:category].present?
      category = Category.find_by(name: params[:category])

      @farms = category.farms
    end

    @markers = @farms.geocoded.map do |f|
        {
          lat: f.latitude,
          lng: f.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { farm: f })
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
