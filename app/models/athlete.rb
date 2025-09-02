class Athlete < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :date_of_birth, presence: true
end
