class Employee < ApplicationRecord
  has_many :team_employees
  has_many :requests
  has_many :shifts
  has_many :teams, through: :team_employees
  has_many :requests
  accepts_nested_attributes_for :teams

  attr_accessor :init_team_id

  def self.assignable_employee_array(team_id)
    Team.find_by_id(team_id).employees.select { |employee| employee.assignable }
  end

  def self.assignable_employee_hash(team_id)
    employee_hash = {}
    team_list = self.assignable_employee_array(team_id)
    team_list.each { |employee| employee_hash[employee.name] = employee.id }
    employee_hash
  end

  def get_next_shift
    Shift.joins(:days).where('shifts.employee_id = ? AND days.value >= ?', self.id, Date.today).order('days.value ASC').limit(1).first
  end

  def get_shift_start_end_day_values
    next_shift = self.get_next_shift
    if next_shift
      days = next_shift.get_shift_days
      { :start => days.first.value, :end => days.last.value }
    else
      nil
    end
  end

end
