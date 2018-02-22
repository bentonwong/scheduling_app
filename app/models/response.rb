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
    shift = self.request.shift
    req_dates = shift.get_start_end_day_values
    "#{req_dates[:start].strftime("%m/%d/%Y")} to #{req_dates[:end].strftime("%m/%d/%Y")}"
  end

  def display_res_info
    shift = self.shift
    res_dates = shift.get_start_end_day_values
    "#{res_dates[:start].strftime("%m/%d/%Y")} to #{res_dates[:end].strftime("%m/%d/%Y")}"
  end

  def self.swap_shifts(res, req)
    req_shift, res_shift = req.shift, res.shift
    req_shift.employee, res_shift.employee  = res_shift.employee, req_shift.employee
    req.update(status: 'completed')
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

end
