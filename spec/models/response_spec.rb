require 'rails_helper'

RSpec.describe Response, type: :model do
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
      "1" => { add_to_request: "1", id: @employee3.shifts.last.id },
      "2" => { add_to_request: "1", id: @employee4.shifts.last.id },
      "3" => { add_to_request: "1", id: @employee5.shifts.last.id }
    }, @request)
    @request.save
  end

  it "respondent can decline a request to swap shifts and does not swap shifts" do
    employee2_response = @employee2.responses.last
    req = Response.update_response({ :choice => "decline", :id => employee2_response.id })
    expect(!@employee2.shifts.include?(req.shift)).to eq(true)
    expect(@employee2.shifts.include?(employee2_response.shift)).to eq(true)
  end

  it "respondent can accept a request to swap shifts and the shifts are swapped" do
    employee3_response = @employee3.responses.last
    req = Response.update_response({ :choice => "accept", :id => employee3_response.id })
    expect(@employee3.shifts.include?(req.shift)).to eq(true)
    expect(!@employee3.shifts.include?(employee3_response.shift)).to eq(true)
    expect(@employee3.responses.last.answer).to eq('accept')
  end

  it "expires opportunity to respond by remaining employees if request accepted" do
    employee3_response = @employee3.responses.last
    req = Response.update_response({ :choice => "accept", :id => employee3_response.id })
    expect(@employee2.responses.last.answer).to eq('expired')
    expect(@employee4.responses.last.answer).to eq('expired')
    expect(@employee5.responses.last.answer).to eq('expired')
  end

end
