require 'rails_helper'

RSpec.describe Employee, type: :model do

  before do
    Employee.destroy_all
    @employee = Employee.create!(name: "Jim")
    @team = Team.create!(name: "Super Dudes!")
    @employee.teams << @team
  end

  it "can create an employee" do
    expect(@employee.name). to eq("Jim")
  end

  it "is not assignable by default" do
    expect(@employee.assignable).to eq(false)
  end

  it "is not an admin by default" do
    expect(@employee.admin).to eq(false)
  end

  it "can be associated with a team" do
    expect(@employee.teams.include?(@team)).to eq(true)
  end

  it "can belong to more than one team" do
    @team2 = Team.create!(name: 'Sales')
    @employee.teams << @team2
    expect(@employee.teams.length > 1). to eq(true)
  end

end
