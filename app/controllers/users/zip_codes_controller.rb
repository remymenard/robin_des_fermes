module Users
  class ZipCodesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :update ]

    def update
      zip_code = params["zip_code"]
      if zip_code.match(/[1-9]\d{3}/)
        if current_user
          current_user.update(zip_code: zip_code)
        else
          cookies.permanent[:zip_code] = zip_code
        end
        render json: zip_code
      else
        render status: 404
      end

      authorize zip_code
    end
  end
end
