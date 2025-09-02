class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end
