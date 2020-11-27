class OpeningHour < ApplicationRecord
  require 'date'

  Date::DAYNAMES = %w(lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche)

  belongs_to :farm

  validates_presence_of :day, :closes, :opens
  validates_inclusion_of :day, :in => 0..6
  validate :opens_before_closes

  validates_uniqueness_of :opens, scope: [:farm_id, :day]
  validates_uniqueness_of :closes, scope: [:farm_id, :day]

  private

  def opens_before_closes
    errors.add(:closes, I18n.t(‘errors.opens_before_closes’)) if opens && closes && opens >= closes
  end
end
