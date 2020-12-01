class User < ApplicationRecord
  #has_many :farms, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates_format_of :zip_code, with: /[1-9]\d{3}/
  has_one_attached :photo

  validates :name, presence: true
end
