class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :authorized?
  before_action :employee_authorized?, except: [:dashboard, :shift_details]

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
    @employee = current_user
    #@team = Team.find_by_id(1)
    #team_shift_ids = @team.collect_shift_ids_by_team
    #@events_by_date = Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
    #@date = params[:date] ? Date.parse(params[:date]) : Date.today
    @next_shift_start_end_days = current_user.get_shift_start_end_day_values
  end

  def shift_details
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :assignable, :admin, :team_ids =>[])
    end

    def set_employee
      @employee = Employee.find_by_id(params[:id])
    end

end
