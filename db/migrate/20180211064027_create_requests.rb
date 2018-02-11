class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :employee_id
      t.integer :requesting_shift_id
      t.integer :responding_shift_id
      t.string :status

      t.timestamps
    end
  end
end
