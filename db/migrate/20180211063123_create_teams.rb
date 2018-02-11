class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :start_day, :default => 0
      t.integer :shift_length, :default => 7

      t.timestamps
    end
  end
end
