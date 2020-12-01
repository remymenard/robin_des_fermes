module Users
  class ZipCodesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :update ]

    def update
      if params["zip_code"].match(/[1-9]\d{3}/)
        if current_user
          current_user.update(zip_code: params["zip_code"])
        else
          cookies.permanent[:zip_code] = params["zip_code"]
        end
      end
    end
  end
end
