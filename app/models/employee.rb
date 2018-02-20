class Employee < ApplicationRecord
  has_many :team_employees
  has_many :requests
  has_many :shifts
  has_many :teams, through: :team_employees
  has_many :requests
  accepts_nested_attributes_for :teams

  attr_accessor :init_team_id

  def next_shift
    Shift.joins(:days).where('shifts.employee_id = ? AND days.value >= ?', self.id, Date.today).order('days.value ASC').limit(1).first
  end

  def get_next_shift_start_end_days
    self.next_shift.get_start_end_day_values
  end

end
