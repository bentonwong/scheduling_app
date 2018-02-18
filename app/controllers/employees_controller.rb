class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :dashboard, :swap]
  before_action :authorized?
  before_action :employee_authorized?, except: [:dashboard, :swap]

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
    @teams = Team.all
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.save ? (redirect_to @employee) : (render :new)
  end

  def show
  end

  def edit
    @teams = Team.all
  end

  def update
    @employee.update(employee_params)
    redirect_to @employee
  end

  def dashboard
  end

  def swap
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :assignable, :admin, :team_ids =>[])
    end

    def set_employee
      @employee = Employee.find_by_id(params[:id])
    end

end
