class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.integer :employee_id
      t.integer :day_id

      t.timestamps
    end
  end
end
