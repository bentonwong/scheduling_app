require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe Shift do

    before do
      Employee.destroy_all
      Team.destroy_all
      @employee = Employee.create!(name: "Jane", assignable: true)
      @team = Team.create!(name: "Customer Support", workday_prefs: '0,1,1,1,1,1,0')
      @employee.teams << @team
      Shift.create_shift(assignment_method: 'manual', employee_id: @employee.id, team_id: @team.id)
    end

    it "can create and assign an employee to a shift" do
      expect(@employee.shifts.length).to eq(1)
    end

    it "assign workdays to match that team's workday preferences" do
      expect(@employee.shifts.last.get_shift_workdays.all? { |day| @team.workday_values_array.include?(day.value.wday) }).to eq(true)
    end

    it "can randomly assign employees on a team to a new shift every week" do
      @employee2 = Employee.create!(name: "Fred", assignable: true)
      @employee2.teams << @team
      @employee3 = Employee.create(name: "Sasha", assignable: true)
      @employee3.teams << @team
      Shift.create_shift(assignment_method: 'automatic', weeks_to_assign: 6, employee_id: @employee.id, team_id: @team.id)
      expect(@team.shifts.length).to eq(7)
    end

    it "detects which days are holidays and does not assign workdays to those days" do
      Shift.create_shift(assignment_method: 'automatic', weeks_to_assign: 52, team_id: @team.id)
      @christmas = Day.where('extract(month from value) = ? AND extract(day from value) = ?', 12, 25)
      @fourth = Day.where('extract(month from value) = ? AND extract(day from value) = ?', 7, 4)
      expect(@christmas.first.holiday).to eq(true)
      expect(@fourth.first.holiday).to eq(true)
      expect(@christmas.first.workday).to eq(false)
      expect(@fourth.first.workday).to eq(false)
    end

  end

end
