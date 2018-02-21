class Response < ApplicationRecord
  belongs_to :request
  belongs_to :employee
  belongs_to :shift

  def concat_response_info
    dates = self.response_start_end_date
    "#{self.employee.name} on #{dates[:start]} to #{dates[:end]}"
  end

  def response_start_end_date
    self.shift.get_start_end_day_values
  end

  def display_res_info
    shift = self.request.shift
    dates = shift.get_start_end_day_values
    "#{dates[:start].strftime("%m/%d/%Y")} to #{dates[:end].strftime("%m/%d/%Y")} by #{shift.employee.name}"
  end

end
