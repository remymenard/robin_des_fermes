class FarmsController < ApplicationController
  def index
    @farms      = Farm.all
    @categories = Category.all

    if params[:category].present?
      category = Category.find_by(name: params[:category])

      @farms = category.farms
    end

    @markers = @farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { farm: farm })
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
  end

  private

  def article_params
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels)
  end
end
