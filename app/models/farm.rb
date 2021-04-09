class Farm < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :farm_orders

  belongs_to :user
  accepts_nested_attributes_for :user, allow_destroy: true

  has_many :farm_categories, dependent: :destroy
  accepts_nested_attributes_for :farm_categories, allow_destroy: true

  has_many :categories, through: :farm_categories
  accepts_nested_attributes_for :categories, allow_destroy: true

  has_many :farm_offices, dependent: :destroy
  accepts_nested_attributes_for :farm_offices, allow_destroy: true

  has_many :offices, through: :farm_offices
  accepts_nested_attributes_for :offices, allow_destroy: true

  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true

  has_many :opening_hours, dependent: :destroy
  accepts_nested_attributes_for :opening_hours, allow_destroy: true

  has_many_attached :photos
  validates_presence_of :photos

  has_one_attached :photo_portrait
  validates_presence_of :photo_portrait

  has_one_attached :farm_profil_picture
  validates_presence_of :farm_profil_picture

  validates :name, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :opening_time, presence: true
  validates :country, presence: true
  validates :description, presence: true
  validates :long_description, presence: true
  validates :delivery_delay, presence: true

  scope :active, -> () { where(active: true) }

  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  DAYS = [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]

  private

  def full_address
    [address, zip_code, city, country].compact.join(', ')
  end
end
