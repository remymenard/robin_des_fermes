module ZipCodeHelper

  def zip_code_set?
    !get_zip_code_number.nil?
  end

  def get_zip_code_number
    stored_zip_code = user_signed_in? ? current_user.zip_code : cookies[:zip_code]
    stored_zip_code ? stored_zip_code : '1200'
  end
end
