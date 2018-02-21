class ResponsesController < ApplicationController

  def update
    res_id, choice = response_params.values_at(:id, :choice)
    res = Response.find_by_id(res_id)
    res.update(answer: choice)
    if choice === "accept"
      req = res.request
      req_shift = req.shift
      res_shift = res.shift
      req_shift.employee, res_shift.employee  = res_shift.employee, req_shift.employee
      req_shift.save
      res_shift.save
      res.save
      req.update(status: "completed")
      req.save
    end
    redirect_to shift_details_path(team_id: req.shift.team.id, id: req.shift.id)
  end

  private

    def response_params
      params.permit(:choice, :id)
    end

end
