class CreateIncomes < ActiveRecord::Migration[8.0]
  def change
    create_table :incomes do |t|
      t.timestamps
      t.string :type
      t.float :unit_value
      t.date :date
    end
  end
end
