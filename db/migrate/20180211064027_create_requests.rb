class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :employee_id
      t.integer :shift_id
      t.string :status, :default => 'sent'

      t.timestamps
    end
  end
end
