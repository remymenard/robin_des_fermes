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
  end

  private

  def article_params
    params.require(:farm).permit(:name, :description, :photo, :adress, :sells, :opening_time, :labels, :category_id)
  end
end
