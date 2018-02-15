class ShiftsController < ApplicationController
  before_action :authorized?

  def index
    @shifts = Shift.all
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

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id)
    end

end
