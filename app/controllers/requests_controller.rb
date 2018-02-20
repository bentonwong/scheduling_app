class RequestsController < ApplicationController
  def create
    raise request_params[:shift_id].inspect
    #raise params[:request][:responses_attributes].inspect
    #@shift = Shift.find_by_id(request_params[:shift_id])
    #@request = Request.create(shift_id: @shift, employee_id: @shift.employee_id)
    #@request.responses.build()
  end

  def update
  end

  private

    def request_params
      params.require(:request).permit(:shift_id, responses_attributes: [:add_to_request, :id])
    end
end
