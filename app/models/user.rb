class User < ApplicationRecord
  #has_many :farms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_format_of :zip_code, with: /\A[1-9]\d{3}\z/

  has_one_attached :photo

  has_many :farms, dependent: :destroy
  has_many :orders, source: :buyer, foreign_key: :buyer_id, dependent: :destroy

  accepts_nested_attributes_for :farms, :allow_destroy => false

  TITLE = ['Mme', 'M']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :number_phone, presence: true

  before_create :subscribe_user_to_mailing_list

  after_create :create_mixpanel
  after_update :update_mixpanel

  def full_name
    [first_name.capitalize, last_name.capitalize].compact.join(' ')
  end

  def is_companion
    unless companion_ending_date.blank?
      return companion_ending_date > Date.current
    end
    false
  end

  private
  def subscribe_user_to_mailing_list
    if @wants_to_subscribe_mailing_list
      Mailchimp::SubscribeToNewsletterService.new(self).call
    end
  end

  def create_mixpanel
    $tracker.people.set(id,
      {
        'Orders Count' => 0
      }
    )
    update_mixpanel
  end

  def update_mixpanel
    $tracker.people.set(id,
      {
        '$first_name' => first_name,
        '$last_name' => last_name,
        '$email' => email,
        '$phone' => number_phone,
        'Delivery Zip Code' => zip_code,
        'Delivery Address' => address_line_1,
        'Delivery City' => city,
        'Admin' => admin
      }
    )
  end
end
