module ZipCodeHelper

  def zip_code?
    !get_zip_code_number.nil?
  end

  def get_zip_code_div
    zip_code = get_zip_code_number
    if zip_code
      return "<p class='zip_code_number'>#{zip_code}</p>"
    else
      return "<p class='zip_code_number'>_______</p>"
    end
  end

  def get_zip_code_number
    if user_signed_in?
      return current_user.zip_code if current_user.zip_code
      return nil
    else
      return cookies[:zip_code] if cookies[:zip_code]
      return nil
    end
  end
end
