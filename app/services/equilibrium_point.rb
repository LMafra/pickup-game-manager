class EquilibriumPoint
  def self.calculate_equilibrium_point(income_types = [], expenses_types = [])
    income_data = income_data(income_types)
    expenses_data = expenses_data(expenses_types)

    return { equilibrium_point: 0, income_total: 0, expenses_total: 0, income_unit_values: {}, expenses_unit_values: {} } if income_data[:total].zero? || income_types.empty?

    equilibrium_point = ((expenses_data[:total] / income_data[:total]).ceil)

    {
      equilibrium_point: equilibrium_point,
      income_total: income_data[:total],
      expenses_total: expenses_data[:total],
      income_unit_values: income_data[:unit_values],
      expenses_unit_values: expenses_data[:unit_values],
      income_count: income_types.count,
      expenses_count: expenses_types.count
    }
  end

  private

  def self.income_data(types)
    return { total: 0, unit_values: {} } if types.empty?

    incomes = Income.joins(:transaction_category)
                    .where(transaction_categories: { name: types })

    total = incomes.sum(:unit_value)
    unit_values = {}

    types.each do |type|
      type_incomes = incomes.where(transaction_categories: { name: type })
      unit_values[type] = {
        unit_value: type_incomes.average(:unit_value)&.round(2) || 0,
        count: type_incomes.count,
        total_value: type_incomes.sum(:unit_value)
      }
    end

    { total: total, unit_values: unit_values }
  end

  def self.expenses_data(types)
    return { total: 0, unit_values: {} } if types.empty?

    expenses = Expense.where(type: types)

    total = expenses.sum { |expense| expense.unit_value * expense.quantity }
    unit_values = {}

    types.each do |type|
      type_expenses = expenses.where(type: type)
      unit_values[type] = {
        unit_value: type_expenses.average(:unit_value)&.round(2) || 0,
        count: type_expenses.count,
        total_value: type_expenses.sum { |expense| expense.unit_value * expense.quantity }
      }
    end

    { total: total, unit_values: unit_values }
  end
end
