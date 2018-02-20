class RequestsController < ApplicationController

  def create
    @shift = Shift.find_by_id(request_params[:request_shift_id])
    @request = Request.create(shift: @shift, employee: @shift.employee)
    response_attributes = request_params[:responses_attributes]
    response_attributes.each do |key, value|
      if value[:add_to_request] === "1"
        request_shift = Shift.find_by_id(value[:id])
        @request.responses.build(shift: request_shift, employee: request_shift.employee)
      end
    end
    @request.save
    redirect_to shift_details_path(team_id: @shift.team.id, id: @shift.id)
  end

  def update
    request = Request.find_by_id(params[:id])
    shift = request.shift
    request.status = 'canceled'
    request.save
    redirect_to shift_details_path(team_id: shift.team_id, id: shift.id)
  end

  private

    def request_params
      params.require(:request).permit(:request_shift_id, responses_attributes: [:add_to_request, :id])
    end
end
