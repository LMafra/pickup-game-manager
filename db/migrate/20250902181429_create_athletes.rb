class CreateAthletes < ActiveRecord::Migration[8.0]
  def change
    create_table :athletes do |t|
      t.string :name
      t.bigint :phone
      t.date :date_of_birth

      t.timestamps
    end
  end
end
