class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.date :date
      t.string :status
      t.references :athlete, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.text :description
      t.float :amount

      t.timestamps
    end
  end
end
