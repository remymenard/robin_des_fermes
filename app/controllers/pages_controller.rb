class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @farms = Farm.all
    @highlighted_farm = @farms.first
    @other_farms      = @farms[1..-1]
  end
end
