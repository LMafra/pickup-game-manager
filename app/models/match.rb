class Match < ApplicationRecord
  validates :date, presence: true
  validates :location, presence: true
end
