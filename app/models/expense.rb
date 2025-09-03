class Expense < ApplicationRecord
  self.inheritance_column = :_type_disabled
  validates :type, presence: true
  validates :description, presence: true
  validates :unit_value, presence: true
  validates :date, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total_value
    unit_value * quantity
  end
end
