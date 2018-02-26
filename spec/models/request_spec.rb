require 'rails_helper'

RSpec.describe Request, type: :model do

  before do
    Employee.destroy_all
    Team.destroy_all
    @team = Team.create!(name: "Customer Support", workday_prefs: '0,1,1,1,1,1,0')
    @req_employee = Employee.create!(name: "Jane", assignable: true)
    @req_employee.teams << @team
    Shift.create_shift(assignment_method: 'manual', employee_id: @req_employee.id, team_id: @team.id)

    @shift = Shift.all.last

    @employee2 = Employee.create!(name: "Fred", assignable: true)
    @employee2.teams << @team
    Shift.create_shift(assignment_method: 'manual', employee_id: @employee2.id, team_id: @team.id)

    @employee3 = Employee.create!(name: "Wilbur", assignable: true)
    @employee3.teams << @team
    Shift.create_shift(assignment_method: 'manual', employee_id: @employee3.id, team_id: @team.id)

    @employee4 = Employee.create!(name: "Sasha", assignable: true)
    @employee4.teams << @team
    Shift.create_shift(assignment_method: 'manual', employee_id: @employee4.id, team_id: @team.id)

    @employee5 = Employee.create!(name: "Kenny", assignable: true)
    @employee5.teams << @team
    Shift.create_shift(assignment_method: 'manual', employee_id: @employee5.id, team_id: @team.id)

    @request = Request.create(shift: @shift, employee: @shift.employee)
    Request.add_resp_obj({
      "0" => { add_to_request: "1", id: @employee2.shifts.last.id },
      "1" => { add_to_request: "0", id: @employee3.shifts.last.id },
      "2" => { add_to_request: "1", id: @employee4.shifts.last.id },
      "3" => { add_to_request: "0", id: @employee5.shifts.last.id }
    }, @request)
    @request.save
  end

  it "can create a request to swap a shift" do
    expect(@req_employee.requests.length).to eq(1)
    expect(@request.employee).to eq(@req_employee)
    expect(@request.shift).to eq(@req_employee.shifts.last)
  end

  it "attaches the request to the correct respondents and shifts" do
    expect(@request.responses.length).to eq(2)
    expect(@request.responses.all? { |response| [@employee2, @employee4].include?(response.employee) }).to eq(true)
    expect(@request.responses.all? { |response| [@employee2.shifts.last, @employee4.shifts.last].include?(response.shift) }).to eq(true)
  end

  it "does not attach the request to unselected respondents and shifts" do
    expect(@request.responses.length).to eq(2)
    expect(@request.responses.all? { |response| ![@employee3, @employee5].include?(response.employee) }).to eq(true)
    expect(@request.responses.all? { |response| ![@employee3.shifts.last, @employee5.shifts.last].include?(response.shift) }).to eq(true)
  end

end
