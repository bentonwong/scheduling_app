class Request < ApplicationRecord
  belongs_to :employee
  belongs_to :shift
  has_many :responses
  accepts_nested_attributes_for :responses

  validates_presence_of  :responses, :message => "Must select at least 1 shift."

  attr_accessor :request_shift_id

  def display_req_info
    Day.format_dates(self.shift)
  end

  def all_responses_declined?
    self.responses.all? { |res| res.answer === 'decline' }
  end

  def all_responses_expired?
    self.responses.all? { |res| res.shift.started? || res.answer === 'expired' }
  end

  def cancel_if_shift_started_or_all_responses_declined_expired
    shift = self.shift
    self.update(status: 'canceled') if shift.started? || self.all_responses_declined? || self.all_responses_expired?
    self.save
  end

  def self.open_requests
    Request.where(status: 'sent')
  end

  def self.update_open_requests
    self.open_requests.each { |request| request.cancel_if_shift_started_or_all_responses_declined_expired }
  end

  def self.add_resp_obj(responses, request)
    responses.each do |key, value|
      if value[:add_to_request] === "1"
        request_shift = Shift.find_by_id(value[:id])
        request.responses.build(shift: request_shift, employee: request_shift.employee)
      end
    end
  end

  def self.cancel_request(id)
    request = Request.find_by_id(id)
    shift = request.shift
    request.status = 'canceled'
    request.save
    shift
  end

end
