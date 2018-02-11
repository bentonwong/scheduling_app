class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :start_day
      t.integer :shift_length

      t.timestamps
    end
  end
end
