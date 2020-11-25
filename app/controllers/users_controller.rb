class UsersController < ApplicationController
  def set_zip_code
    if params["zip_code"]
      if params["zip_code"].match(/[1-9]\d{3}/)
        if current_user
          current_user.update(zip_code: params["zip_code"])
        else

        end
      end
    end
  end
end
