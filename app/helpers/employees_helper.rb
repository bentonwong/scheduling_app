module EmployeesHelper

  def closed_swap_request_tag(request)
    if request.status === "completed"
      {msg: "COMPLETED", color: "green"}
    elsif request.all_responses_declined?
      {msg: "DECLINED", color: "red"}
    elsif request.all_responses_expired? || request.shift.started?
      {msg: "EXPIRED", color: "red"}
    else
      {msg: "CANCELED", color: "yellow darken-3"}
    end
  end

  def closed_swap_response_tag(response)
    if response.answer === "waiting"
      {msg: "WAITING", color: "grey"}
    elsif response.answer === "decline"
      {msg: "DECLINED", color: "red"}
    elsif response.answer === "accept"
      {msg: "ACCEPTED", color: "green"}
    else
      {msg: "EXPIRED", color: "red"}
    end
  end

  def active_swap_requests?(shift)
    shift.active_swap_requests?
  end

  def shift_team_curent_shift(shift)
    shift.team.current_shift
  end

  def shift_started?(shift)
    shift.started?
  end

  def responses_of_sent_request(shift)
    shift.responses_of_sent_request
  end

  def concat_response_info(response)
    response.concat_response_info
  end

  def active_swap_request(shift)
    shift.active_swap_request
  end

end
