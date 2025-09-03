class EquilibriumPoint < ApplicationRecord
  def self.calculate_equilibrium_point(income_types = [], expenses_types = [])
    income = income_value(income_types)
    expenses = expenses_value(expenses_types)

    return 0 if income.zero? || income_types.empty?

    ((expenses / income).ceil) / income_types.count
  end

  private

  def self.income_value(types)
    return 0 if types.empty?
    Income.where(type: types).map { |income| income.unit_value }.sum
  end

  def self.expenses_value(types)
    return 0 if types.empty?
    Expense.where(type: types).map { |expense| expense.unit_value * expense.quantity }.sum
  end
end
