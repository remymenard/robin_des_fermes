class FarmsController < ApplicationController

  def article_params
    params.require(:farm).permit(:name, :description, :photo)
  end
end
