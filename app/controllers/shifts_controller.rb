class ShiftsController < ApplicationController
  before_action :authorized?

  def index
    @shifts = Shift.all
  end

  def new
    @shift = Shift.new
    @team_id = params[:team_id]
    @employee_list = employee_list
    @weeks_array = Shift.weeks_array
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.save ? (redirect_to team_shifts) : (redirect_to team_shifts)
  end

  private

    def shift_params
      params.require(:shift).permit(:assignment_method, :weeks_to_assign, :employee_id, :team_id)
    end

    def employee_list
      @employee_list = {}
      team_list = Team.find_by_id(params[:team_id]).employees
      team_list.each { |employee| @employee_list[employee.name] = employee.id }
      @employee_list
    end

end
