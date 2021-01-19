module Users
  class AdminsController < ApplicationController
    def search
      @q = User.ransack(params[:q])
      render json: @q.result(distinct: true).map { |user| {id: user.id, full_name: user.first_name.capitalize + " " + user.last_name.capitalize} }
    end
  end
end
