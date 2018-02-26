class Team < ApplicationRecord
  has_many :shifts
  has_many :team_employees
  has_many :employees, through: :team_employees

  validates :name, :workday_prefs, presence: :true
  validates :name, uniqueness: :true

  attr_accessor :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday

  DAYS_OF_THE_WEEK = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']

  WEEKDAY_TO_VALUE = {
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6
  }

  def self.days_of_the_week
    DAYS_OF_THE_WEEK
  end

  def self.day_value(day)
    WEEKDAY_TO_VALUE[day.to_sym]
  end

  def workday_values_array
    self.workday_prefs_values
  end

  def collect_shift_ids_by_team
    self.shifts.collect { |shift| shift.id }.uniq
  end

  def sorted_team_employees_by_id
    self.employees.sort_by{ |employee| employee.id }
  end

  def current_shift
    days = Day.where("value = ?", Date.today)
    day = days.find { |day| day.shift.team === self }
    if day
      if day.shift.started? && !day.shift.ended?
        return day.shift
      end
    end
    nil
  end

  def next_shift
    self.upcoming_shifts.first
  end

  def upcoming_shifts
    days = Day.where("value > ?", Date.today)
    filtered_days = days.select { |day| day.shift.team === self && day.shift != self.current_shift }
    upcoming_shifts = filtered_days.collect { |day| day.shift }.uniq
    upcoming_shifts.sort_by { |shift| shift.days.min }
  end

  def assignable_employee_array
    self.employees.select { |employee| employee.assignable }
  end

  def events_by_date
    team_shift_ids = self.collect_shift_ids_by_team
    Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
  end

  def upcoming_shifts_days
    days = Day.where("value > ?", Date.today)
    days.select { |day| day.shift.team === self }
  end

  def workday_prefs_values
    result = []
    workday_prefs = self.split_workday_prefs
    workday_prefs.each_with_index do |element, index|
      result << index if element === '1'
    end
    result
  end

  def split_workday_prefs
    self.workday_prefs.split(',')
  end

end
