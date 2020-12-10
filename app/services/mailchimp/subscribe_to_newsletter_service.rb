module Mailchimp
  class SubscribeToNewsletterService
    def initialize(user)
      @user = user
      @list_id = ENV["MAILCHIMP_LIST_ID"]
      @gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    end

    def call
      @gibbon.lists(@list_id).members.create(
        body: request_body
      )
    end

    private
    def request_body
      {
        email_address: @user.email,
        status: "subscribed",
        merge_fields: {
          FNAME: @user.first_name,
          LNAME: @user.last_name,
          ADDRESS: {
            addr1: @user.address,
            city: @user.city,
            state: "",
            country: "Switzerland",
            zip: @user.zip_code
          }
        }
      }
    end
  end
end
