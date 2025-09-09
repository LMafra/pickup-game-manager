class RemoveTypeAtIncomes < ActiveRecord::Migration[8.0]
  def change
    remove_column :incomes, :type, :string
  end
end
