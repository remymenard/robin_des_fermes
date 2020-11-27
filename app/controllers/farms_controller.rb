class FarmsController < ApplicationController
  require 'date'

  def index
    @farms      = Farm.all
    @categories = Category.all

    if params[:category].present?
      category = Category.find_by(name: params[:category])

      @farms = category.farms
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


  end

  private

  def article_params
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels)
  end
end
