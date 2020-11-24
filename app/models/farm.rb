class Farm < ApplicationRecord
  belongs_to :user
  has_many :farm_categories, dependent: :destroy
  has_many :categories, through: :farm_categories

  has_many_attached :photos

  LABELS = ['bio']

  validates :name, presence: true
  # validates :labels, presence: true
  validates :sells, presence: true
  validates :address, presence: true
  validates :opening_time, presence: true

  def self.where_category_name(category_name)
    category = Category.find_by(name: category_name)

    Farm.all.select { |farm| farm.categories.include?(category) }
  end
end
