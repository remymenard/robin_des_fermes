class FarmsController < ApplicationController
  def index
    @farms = Farm.all
    @categories = Category.all

    if params[:query].present?
      @farms = Farm.where_category_name(params[:query])
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
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels, :category_id)
  end
end
