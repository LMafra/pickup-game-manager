class AddQuantityToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :quantity, :integer
  end
end
