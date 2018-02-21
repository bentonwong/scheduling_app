module EmployeesHelper

  def closed_swap_request_tag(request)
    if request.status === "completed"
      {msg: "COMPLETED", color: "green"}
    elsif request.all_declined?
      {msg: "DECLINED", color: "red"}
    else
      {msg: "CANCELED", color: "yellow darken-3"}
    end
  end

end
