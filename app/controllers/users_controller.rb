class UsersController < ApplicationController
  def set_zip_code
    puts current_user.email
  end
end
