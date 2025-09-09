class AddTransactionCategoryRefToIncomes < ActiveRecord::Migration[8.0]
  def change
    add_reference :incomes, :transaction_category, null: false, foreign_key: true
  end
end
