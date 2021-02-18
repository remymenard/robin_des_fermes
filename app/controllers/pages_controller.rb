class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :cgv, :faq, :team, :about, :impressum, :community, :charter, :partners, :producer]

  def home
    @farms = Farm.all
    @highlighted_farm = @farms.first
    @other_farms      = Farm.order("id asc").offset(1).all

    @reassurance = true
  end

  def cgv
  end

  def faq
  end

  def team
  end

  def about
  end

  def impressum
  end

  def community
  end

  def charter
  end

  def partners
  end

  def producer
  end
end
