class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
    @teams = Team.all
  end

  def create
    raise params.inspect
  end

end
