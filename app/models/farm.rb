class Farm < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  belongs_to :user
  accepts_nested_attributes_for :user, allow_destroy: true

  has_many :farm_categories, dependent: :destroy
  accepts_nested_attributes_for :farm_categories, allow_destroy: true

  has_many :categories, through: :farm_categories
  accepts_nested_attributes_for :categories, allow_destroy: true

  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true

  has_many :opening_hours, dependent: :destroy
  accepts_nested_attributes_for :opening_hours, allow_destroy: true

  has_many_attached :photos

  LABELS = ["Bio-Suiss", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]
  # validates :labels, inclusion: { in: LABELS }

  validates :name, presence: true
  # validates :labels, presence: true
  validates :address, presence: true
  # validates :opening_time, presence: true
  # validates :regions, presence: true

  scope :active, -> ()    { where(active: true) }
end
