class Farm < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  belongs_to :user
  has_many :farm_categories, dependent: :destroy
  has_many :categories, through: :farm_categories
  has_many :products, dependent: :destroy
  has_many :opening_hours, dependent: :destroy

  has_many_attached :photos

  LABELS = ["Bio-Suiss", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]
  # validates :labels, inclusion: { in: LABELS }

  validates :name, presence: true
  # validates :labels, presence: true
  validates :address, presence: true
  # validates :opening_time, presence: true
  # validates :regions, presence: true
end
