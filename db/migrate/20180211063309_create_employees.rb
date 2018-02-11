class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.boolean :assignable, :default => false
      t.string :role, :default => 'employee'

      t.timestamps
    end
  end
end
