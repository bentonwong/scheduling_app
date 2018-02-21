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

end
