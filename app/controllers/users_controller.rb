class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :set_zip_code ]

  def set_zip_code
    if params["zip_code"]
      if params["zip_code"].match(/[1-9]\d{3}/)
        if current_user
          current_user.update(zip_code: params["zip_code"])
        else
          puts "SET"
          cookies.permanent[:zip_code] = params["zip_code"]
        end
      end
    end
  end

end
