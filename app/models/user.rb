class User < ApplicationRecord
  #has_many :farms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_format_of :zip_code, with: /\A[1-9]\d{3}\z/, allow_blank: true

  has_one_attached :photo

  has_many :farms, dependent: :destroy
  accepts_nested_attributes_for :farms, :allow_destroy => false

  TITLE = ['Mme', 'M']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :title, presence: true

  before_create :subscribe_user_to_mailing_list

  private
  def subscribe_user_to_mailing_list
    if @wants_to_subscribe_mailing_list
      Mailchimp::SubscribeToNewsletterService.new(self).call
    end
  end
end
