class Farm < ApplicationRecord
  belongs_to :user
  has_many :farm_categories, dependent: :destroy
  has_many :categories, through: :farm_categories
  has_many :products, dependent: :destroy

  has_many_attached :photos

  LABELS = ["bio"]
  # validates :labels, inclusion: { in: LABELS }

  validates :name, presence: true
  # validates :labels, presence: true
  validates :address, presence: true
  validates :opening_time, presence: true
end
