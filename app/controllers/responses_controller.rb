class ResponsesController < ApplicationController

  def update
    res_id, choice = response_params.values_at(:id, :choice)
    res = Response.find_by_id(res_id)
    res.update(answer: choice)
    req = res.request
    if choice === "accept"
      Response.swap_shifts(res, req)
      redirect_to shift_details_path(team_id: req.shift.team.id, id: req.shift.id)
    else
      req.cancel_if_shift_started_or_all_responses_declined_expired
      req.save
      res.save
      redirect_to dashboard_path
    end
  end

  private

    def response_params
      params.permit(:choice, :id)
    end

end
