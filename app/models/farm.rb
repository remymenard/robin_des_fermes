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

  after_save :add_office_values_to_regions

  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  DAYS = [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]

  def delivery_date(zip_code)
    if self.regions.include?(zip_code)
      farm_office = farm_offices.select do |farm_office|
        farm_office.office.regions.include? zip_code
      end
      days = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
      now = Time.now
      if now.wday == farm_office.first.delivery_deadline_day && now.to_formatted_s(:time) < farm_office.first.delivery_deadline_hour
        Date.today + farm_office.first.delivery_day
      else
        Date.today.next_occurring(days[farm_office.first.delivery_deadline_day]) + farm_office.first.delivery_day
      end
    else
      Date.current + 1 + self.delivery_delay
    end
  end

  def is_in_close_zone?(zip_code)
    is_in_close_zone = false
    farm_offices.each do |farm_office|
      is_in_close_zone = true if farm_office.office.regions.include?(zip_code)
    end
    is_in_close_zone
  end

  private

  def add_office_values_to_regions
    self.regions = []
    self.offices.each { |office| regions << office.regions }

    # Build one single array (not an array of arrays)
    self.regions = self.regions.join(" ").split

    # Remove empty values
    self.regions.reject!(&:empty?)
  end


  def full_address
    [address, zip_code, city, country].compact.join(', ')
  end
end
