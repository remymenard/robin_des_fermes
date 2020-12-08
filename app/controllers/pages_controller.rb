class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @farms = Farm.all
    @highlighted_farm = @farms.first
    @other_farms      = Farm.order("id asc").offset(1).all
  end
end
