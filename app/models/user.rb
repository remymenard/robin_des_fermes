class User < ApplicationRecord
  #has_many :farms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :wants_to_subscribe_mailing_list
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_format_of :zip_code, with: /[1-9]\d{3}/, allow_blank: true

  has_one_attached :photo

  TITLE = ['Mme', 'M']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :title, presence: true

  before_create :subscribe_user_to_mailing_list

  private
  def subscribe_user_to_mailing_list
    if @wants_to_subscribe_mailing_list == "1"
      list_id = ENV["MAILCHIMP_LIST_ID"]
      gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
      gibbon.lists(list_id).members.create(
        body: {
          email_address: self.email,
          status: "subscribed",
          merge_fields: {
            FNAME: self.first_name,
            LNAME: self.last_name,
            ADDRESS: {
              addr1: self.address,
              city: self.city,
              state: "",
              country: "Switzerland",
              zip: self.zip_code
            }
          }
        }
      )
    end
  end
end
