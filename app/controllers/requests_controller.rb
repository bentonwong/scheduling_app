class RequestsController < ApplicationController

  def create
    @shift = Shift.find_by_id(request_params[:request_shift_id])
    @request = Request.create(shift: @shift, employee: @shift.employee)
    Request.add_resp_obj(request_params[:responses_attributes], @request)
    if @request.save
      redirect_to shift_details_path(team_id: @shift.team.id, id: @shift.id)
    else
      @potential_trades = @shift.get_potential_trades
      render :template => 'employees/shift_details'
    end
  end

  def update
    req_shift = Request.cancel_request(params[:id])
    redirect_to shift_details_path(team_id: req_shift.team_id, id: req_shift.id)
  end

  private

    def request_params
      params.require(:request).permit(:request_shift_id, responses_attributes: [:add_to_request, :id])
    end
end
