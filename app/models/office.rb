class Office < ApplicationRecord
  has_many :farm_offices, dependent: :destroy
  has_many :farm

#   before_save :add_office_values_to_regions

#   private

#   def add_office_values_to_regions
#     self.regions = []

#     self.regions << OFFICES[self.name]

#     # Build one single array (not an array of arrays)
#     self.regions = regions.join(" ").split

#     # Remove empty values
#     self.regions.reject!(&:empty?)
#   end
end
