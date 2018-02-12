class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
    @teams = Team.all
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new
    end
  end

  def show
    @employee = Employee.find_by_id(params[:id])
  end

  def edit
    @employee = Employee.find_by_id(params[:id])
    @teams = Team.all
  end

  def update
    @employee = Employee.find_by_id(params[:id])
    @employee.update(employee_params)
    redirect_to @employee
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :assignable, :role)
    end

end
