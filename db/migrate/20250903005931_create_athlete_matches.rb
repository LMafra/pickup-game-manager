class CreateAthleteMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :athlete_matches do |t|
      t.references :athlete, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
