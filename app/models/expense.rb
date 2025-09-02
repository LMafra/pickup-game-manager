class Expense < ApplicationRecord
  self.inheritance_column = :_type_disabled
  validates :type, presence: true
  validates :description, presence: true
  validates :unit_value, presence: true
  validates :date, presence: true
end
