class ShiftsController < ApplicationController
  before_action :authorized?

  def index
    @shifts = Shift.all
  end

  def new
    @shift = Shift.new
    @team_id = params[:team_id]
    @employee_list = Shift.assignable_employee_list(@team_id)
    @weeks_array = Shift.weeks_array
  end

  def create
    #@shift = Shift.new(shift_params)
    @shift.save ? (redirect_to team_shifts) : (re)
  end

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id)
    end

end
