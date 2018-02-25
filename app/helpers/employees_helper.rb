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

  def sort_employees_by_id(employees)
    employees.sort_by(&:id)
  end

  def employee_open_requests?(employee)
    employee.open_requests?
  end

  def employee_open_requests(employee)
    employee.open_requests
  end

  def employee_closed_requests?(employee)
    employee.closed_requests?
  end

  def employee_closed_requests(employee)
    employee.closed_requests
  end

  def display_req_info(instance)
    instance.display_req_info
  end

  def display_res_info(response)
    response.display_res_info
  end

  def employee_awaiting_responses?(employee)
    employee.awaiting_responses?
  end

  def employee_awaiting_responses(employee)
    employee.awaiting_responses
  end

  def employee_next_shift(employee)
    employee.next_shift
  end

  def format_next_shift_dates(day)
    day.strftime("%A, %m/%d/%Y")
  end

  def random_string
    SecureRandom.hex(8)
  end

end
