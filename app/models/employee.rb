class Employee < ApplicationRecord
  has_many :team_employees
  has_many :requests
  has_many :shifts
  has_many :teams, through: :team_employees
  has_many :responses
  accepts_nested_attributes_for :teams

  attr_accessor :init_team_id

  def next_shift
    Shift.joins(:days).where('shifts.employee_id = ? AND days.value >= ?', self.id, Date.today).order('days.value ASC').limit(1).first
  end

  def get_next_shift_start_end_days
    self.next_shift.get_start_end_day_values
  end

  def open_requests
    self.requests.select { |req| req.status === 'sent' }
  end

  def open_requests?
    self.open_requests.length > 0
  end

  def closed_requests?
    self.closed_requests.length > 0
  end

  def closed_requests
    self.requests.select { |req| req.status != 'sent' && !req.shift.started? }
  end

  def awaiting_responses?
    self.awaiting_responses.length > 0
  end

  def awaiting_responses
    self.responses.select { |res| res.request.status = "sent" && !res.request.shift.started? && res.answer === "waiting"}
  end

end
