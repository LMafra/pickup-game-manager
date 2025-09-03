class Match < ApplicationRecord
  has_many :payments, dependent: :destroy
  has_many :athlete_matches, dependent: :destroy
  has_many :athletes, through: :athlete_matches

  validates :date, presence: true
  validates :location, presence: true
end
