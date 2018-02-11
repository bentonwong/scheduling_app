class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.integer :shift_id
      t.boolean :holiday
      t.boolean :workday

      t.timestamps
    end
  end
end
