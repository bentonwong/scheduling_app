class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :authorized?
  before_action :set_teams, only: [:new, :create, :edit, :update]
  before_action :employee_authorized?, except: [:dashboard, :shift_details]

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.save ? (redirect_to @employee) : (render :new)
  end

  def show
  end

  def edit
  end

  def update
    @employee.update(employee_params)
    @employee.save ? (redirect_to @employee) : (render :edit)
  end

  def dashboard
    @employee = current_user
    @next_shift_start_end_days = @employee.get_next_shift_start_end_days
    set_dashboard_calendar
  end

  def shift_details
    @shift = Shift.find_by_id(params[:id])
    @request = Request.new
    @potential_trades = @shift.get_potential_trades
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :assignable, :admin, :team_ids)
    end

    def set_employee
      @employee = Employee.find_by_id(params[:id])
    end

    def set_teams
      @teams = Team.all
    end

    def set_dashboard_calendar
      if params[:employee]
        if !employee_params[:team_ids].blank?
          team_id = employee_params[:team_ids]
        else
          team_id = @employee.teams.first.id
        end
      else
        team_id = @employee.teams.first.id
      end
      @team = Team.find_by_id(team_id)
      team_shift_ids = @team.collect_shift_ids_by_team
      @events_by_date = Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    end

end
