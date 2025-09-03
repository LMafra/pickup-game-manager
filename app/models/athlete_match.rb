class AthleteMatch < ApplicationRecord
  belongs_to :athlete
  belongs_to :match

  validates :athlete_id, uniqueness: { scope: :match_id, message: "has already been taken" }
end
