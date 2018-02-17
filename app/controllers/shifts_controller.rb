class ShiftsController < ApplicationController
  before_action :authorized?
  before_action :employee_authorized?
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  def index
    @team = Team.find_by_id(params[:team_id])
    team_shift_ids = @team.collect_shift_ids_by_team
    @events_by_date = Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @shift = Shift.new
    @team_id = params[:team_id]
    @employee_list = Employee.assignable_employee_hash(@team_id)
    @weeks_array = Shift.weeks_array
  end

  def create
    Shift.create_shift(*shift_params)
    redirect_to team_shifts_path
  end

  def show
  end

  def edit
    @team_id = params[:team_id]
    @employees = Employee.assignable_employee_hash(@team_id)
  end

  def update
    raise params.inspect
  end

  def destroy
    @shift.destroy
    redirect_to team_shifts_path(params[:team_id])
  end

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id, :selected_date)
    end

    def set_shift
      @shift = Shift.find_by_id(params[:id])
    end

end
