class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.timestamps
      t.string :type
      t.string :description
      t.float :unit_value
      t.date :date
    end
  end
end
