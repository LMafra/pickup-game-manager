class TransactionCategory < ApplicationRecord
  has_many :incomes
  has_many :payments

  validates :name, presence: true, uniqueness: true
end
