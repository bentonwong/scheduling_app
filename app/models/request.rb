class Request < ApplicationRecord
  belongs_to :employee
  belongs_to :shift
  has_many :responses
  accepts_nested_attributes_for :responses

  attr_accessor :request_shift_id

  def display_open_req_info
    shift = self.shift
    dates = shift.get_start_end_day_values
    "#{dates[:start].strftime("%m/%d/%Y")} to #{dates[:end].strftime("%m/%d/%Y")}"
  end

  def display_closed_req_info
    shift = self.shift
    dates = shift.get_start_end_day_values
    "#{dates[:start].strftime("%m/%d/%Y")} to #{dates[:end].strftime("%m/%d/%Y")}"
  end

  def all_declined?
    self.responses.all? { |res| res.answer === 'declined' }
  end

end
