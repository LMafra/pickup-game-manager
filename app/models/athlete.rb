class Athlete < ApplicationRecord
  has_many :payments, dependent: :destroy
  has_many :athlete_matches, dependent: :destroy
  has_many :matches, through: :athlete_matches

  validates :name, presence: true
  validates :phone, presence: true
  validates :date_of_birth, presence: true
end
