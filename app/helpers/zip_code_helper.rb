module ZipCodeHelper

  def zip_code_set?
    !get_zip_code_number.nil?
  end

  def get_zip_code_number
    user_signed_in? ? current_user.zip_code : cookies[:zip_code]
  end
end
