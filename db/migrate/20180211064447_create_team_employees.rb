class CreateTeamEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :team_employees do |t|
      t.integer :team_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
