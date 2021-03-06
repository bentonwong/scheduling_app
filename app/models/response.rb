class Response < ApplicationRecord
  belongs_to :request
  belongs_to :employee
  belongs_to :shift

  attr_accessor :choice

  def concat_response_info
    dates = self.response_start_end_date
    "#{self.employee.name} on #{dates[:start]} to #{dates[:end]}"
  end

  def response_start_end_date
    self.shift.get_start_end_day_values
  end

  def display_req_info
    Day.format_dates(self.request.shift)
  end

  def display_res_info
    Day.format_dates(self.shift)
  end

  def self.swap_shifts(res, req)
    req_shift, res_shift = req.shift, res.shift
    req_shift.employee, res_shift.employee  = res_shift.employee, req_shift.employee
    req.update(status: 'completed')
    Response.update_open_responses
    instances = [req_shift, res_shift, req, res]
    instances.each { |instance| instance.save }
  end

  def expire_res
    req = self.request
    res_shift, req_shift = self.shift, req.shift
    if res_shift.started? || req_shift.started? || ['completed', 'canceled'].include?(req.status)
      self.update(answer: 'expired')
      self.save
    end
  end

  def self.open_responses
    self.where(answer: 'waiting')
  end

  def self.update_open_responses
    self.open_responses.each { |res| res.expire_res }
  end

  def self.update_response(params)
    res_id, choice = params.values_at(:id, :choice)
    res = Response.find_by_id(res_id)
    res.update(answer: choice)
    req = res.request
    if choice === "accept"
      Response.swap_shifts(res, req)
    else
      req.cancel_if_shift_started_or_all_responses_declined_expired
      req.save
      res.save
    end
    req
  end

end
