class Request < ApplicationRecord
  belongs_to :employee
  belongs_to :shift
  has_many :responses
  accepts_nested_attributes_for :responses

  validates_presence_of  :responses, :message => "Must select at least 1 shift."

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

  def all_responses_declined?
    self.responses.all? { |res| res.answer === 'decline' }
  end

  def all_responses_expired?
    self.responses.all? { |res| res.shift.started? || res.answer === 'expired' }
  end

  def cancel_if_shift_started_or_all_responses_declined_expired
    shift = self.shift
    self.status = "canceled" if shift.started? || self.all_responses_declined? || self.all_responses_expired?
    self.save
  end

end
