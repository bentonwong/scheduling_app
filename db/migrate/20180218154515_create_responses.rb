class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.integer :request_id
      t.integer :employee_id
      t.string :answer, :default => 'waiting'

      t.timestamps
    end
  end
end
