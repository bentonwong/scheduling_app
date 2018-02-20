class RequestsController < ApplicationController
  def create
    raise params[:id].inspect
    raise params[:request][:responses_attributes].inspect
    @shift = Shift.find_by_id(params[:id])
    @request = Request.create(shift_id: )
  end

  def update
  end

  private

    def request_params
      params.require(:requests).permit(:id)
    end
end
