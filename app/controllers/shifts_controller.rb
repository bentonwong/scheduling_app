class ShiftsController < ApplicationController
  before_action :authorized?
  before_action :employee_authorized?

  def index
    team_shift_ids = Team.collect_shift_ids_by_team(params[:team_id])
    @events_by_date = Day.where(shift_id: team_shift_ids).group_by(&:value)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @shifts = Shift.current_and_upcoming_shifts(5)
  end

  def new
    @shift = Shift.new
    @team_id = params[:team_id]
    @employee_list = Shift.assignable_employee_hash(@team_id)
    @weeks_array = Shift.weeks_array
  end

  def create
    Shift.create_shift(*shift_params)
    redirect_to team_shifts_path
  end

  def show
    @shift = Shift.find_by_id(params[:id])
  end

  def edit
    @shift = Shift.find_by_id(params[:id])
  end

  def show_by_date
    date = shift_params[:selected_date]
    shift = Day.find_by(value: date).shift
    redirect_to team_shift_path(team_id: shift.team_id, id: shift.id)
  end

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id, :selected_date)
    end

end
