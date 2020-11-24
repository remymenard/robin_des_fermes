class Farm < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  LABELS = ['bio']

  validates :name, presence: true
  # validates :labels, presence: true
  validates :sells, presence: true
  validates :address, presence: true
  validates :opening_time, presence: true
end
