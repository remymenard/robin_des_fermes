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

  after_save :set_regions

  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  DAYS = [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]

  NOW = Time.now

  DAYS_DELIVERY = %i[monday tuesday wednesday thursday friday saturday sunday]

  def delivery_date(zip_code)
    if is_in_close_zone?(zip_code)
      # if regional delivery
      farm_office = get_correct_farm_office(zip_code)
      date = Date.new
      if NOW.wday == farm_office.delivery_deadline_day && NOW.to_formatted_s(:time) < farm_office.delivery_deadline_hour
        date = NOW
      else
        date = NOW.next_occurring(DAYS_DELIVERY[farm_office.delivery_deadline_day])
      end
      date.next_occurring(DAYS_DELIVERY[farm_office.delivery_day])
    else
      # if national delivery
      NOW + 1.day + delivery_delay.days
    end
  end

  def is_in_close_zone?(zip_code)
    is_in_close_zone = false
    farm_offices.each do |farm_office|
      is_in_close_zone = true if farm_office.office.regions.include?(zip_code)
    end
    is_in_close_zone
  end

  def delay_date(zip_code)
    farm_office = get_correct_farm_office(zip_code)
    Date.today.next_occurring(DAYS_DELIVERY[farm_office.delivery_deadline_day])
  end

  def delay_hour(zip_code)
    farm_office = get_correct_farm_office(zip_code)
    farm_office.delivery_deadline_hour
  end

  private

  def get_correct_farm_office(zip_code)
    farm_offices.find do |farm_office|
      farm_office.office.regions.include? zip_code
    end
  end

  def set_regions
    all_regions = []

    self.offices.each { |office| all_regions << office.regions }

    # Build one single array (not an array of arrays)
    all_regions = all_regions.join(" ").split

    # Remove empty values
    all_regions.reject!(&:empty?)

    self.update_column(:regions, all_regions)
  end

  def full_address
    [address, zip_code, city, country].compact.join(', ')
  end
end
