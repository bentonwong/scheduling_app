class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.integer :shift_id
      t.date :value
      t.boolean :holiday, :default => false
      t.boolean :workday, :default => true

      t.timestamps
    end
  end
end
