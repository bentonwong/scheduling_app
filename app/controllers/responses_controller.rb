class ResponsesController < ApplicationController

  def update
    req = Response.update_response(response_params)
    if response_params[:choice] === "accept"
      redirect_to shift_details_path(team_id: req.shift.team.id, id: req.shift.id)
    else
      redirect_to dashboard_path
    end
  end

  private

    def response_params
      params.permit(:choice, :id)
    end

end
