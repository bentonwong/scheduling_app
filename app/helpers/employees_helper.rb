module EmployeesHelper

  def closed_swap_request_tag(request)
    if request.status === "completed"
      {msg: "COMPLETED", color: "green"}
    elsif request.all_responses_declined?
      {msg: "DECLINED", color: "red"}
    elsif request.all_responses_expired?
      {msg: "EXPIRED", color: "red"}
    else
      {msg: "CANCELED", color: "yellow darken-3"}
    end
  end

end
