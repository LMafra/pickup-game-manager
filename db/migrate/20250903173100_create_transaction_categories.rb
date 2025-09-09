class CreateTransactionCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :transaction_categories do |t|
      t.timestamps
      t.string :name, null: false
      t.text :description
    end

    add_index :transaction_categories, :name, unique: true
  end
end
