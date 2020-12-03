class User < ApplicationRecord
  #has_many :farms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
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
end
