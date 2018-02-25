class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :workday_prefs, :default => '0,0,0,0,0,0,0'

      t.timestamps
    end
  end
end
