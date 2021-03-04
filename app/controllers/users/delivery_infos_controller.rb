module Users
  class DeliveryInfosController < ApplicationController
    def edit
      skip_authorization
      @user = current_user

    end
    def update
      skip_authorization
      @user = current_user
      if @user.update(user_params)
        redirect_to stored_location_for(:user)
      else
        render 'edit'
      end

    end

    private
    def user_params
      params.require(:user).permit(:address_line_1, :zip_code, :city, :number_phone)
    end
  end
end
