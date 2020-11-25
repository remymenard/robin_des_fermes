class FarmsController < ApplicationController
  def index
    @farms = Farm.all
    @categories = Category.all

    if params[:query].present?
      category = Category.find_by(name: params[:query])
      @farms   = category.farms
    end
  end

  private

  def article_params
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels)
  end
end
