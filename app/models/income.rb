class Income < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :transaction_category

  validates :type, presence: true
  validates :unit_value, presence: true
  validates :date, presence: true

  def type
    transaction_category&.name
  end

  def type=(value)
    self.transaction_category = TransactionCategory.find_by(name: value)
  end
end
