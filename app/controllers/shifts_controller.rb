class ShiftsController < ApplicationController
  before_action :authorized?
  before_action :employee_authorized?
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index, :new, :edit]

  def index
    @events_by_date = @team.events_by_date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @shift = Shift.new
    @employees = @team.assignable_employee_hash
    @weeks = Shift.weeks_array
  end

  def create
    Shift.create_shift(*shift_params)
    redirect_to team_shifts_path
  end

  def show
  end

  def edit
    @employees = @team.assignable_employee_hash
  end

  def update
    @shift.update(shift_params)
    if @shift.save
        redirect_to team_shift_path(@shift)
      else
        redirect_to edit_team_shift_path(team_id: @shift.team.id, id: @shift.id)
      end
  end

  def destroy
    @shift.days.destroy
    @shift.destroy
    redirect_to team_shifts_path(params[:team_id])
  end

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id, :selected_date, days_attributes: [:id, :workday])
    end

    def set_shift
      @shift = Shift.find_by_id(params[:id])
    end

    def set_team
      @team = Team.find_by_id(params[:team_id])
    end

end
