class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :cgv, :faq]

  def home
    @farms = Farm.all
    @highlighted_farm = @farms.first
    @other_farms      = Farm.order("id asc").offset(1).all
  end

  def cgv
  end

  def faq
  end

  def team
  end
end
