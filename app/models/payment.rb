class Payment < ApplicationRecord
  belongs_to :athlete
  belongs_to :match
  validates :amount, presence: true
  validates :status, presence: true
end
