class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :authorized?
  before_action :set_teams, only: [:new, :edit]
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
    redirect_to @employee
  end

  def dashboard
    set_dashboard_employee_info
    set_shift_picker_params
    set_calendar_params
    @response = Response.new
  end

  def shift_details
    @shift = Shift.find_by_id(params[:id])
    @request = Request.new
    @potential_trades = @shift.get_potential_trades
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :assignable, :admin, :team_ids =>[])
    end

    def set_employee
      @employee = Employee.find_by_id(params[:id])
    end

    def set_teams
      @teams = Team.all
    end

    def set_calendar_params
      team_ids = params.dig(:employee, :team_ids) || @employee.teams.first.id
      if team_ids
        @team = Team.find_by_id(team_ids)
        team_shift_ids = @team.collect_shift_ids_by_team
        @events_by_date = Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
      end
    end

    def set_shift_picker_params
      @shift_calendar_form = Employee.new
      @employee_team_select = {}
      @employee.teams.each { |team| @employee_team_select[team.name] = team.id }
    end

    def set_dashboard_employee_info
      @employee = current_user
      @next_shift_start_end_days = @employee.get_next_shift_start_end_days
    end

end
