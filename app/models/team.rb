class Team < ApplicationRecord
  has_many :shifts
  has_many :team_employees
  has_many :employees, through: :team_employees

  validates :name, presence: :true
  validates :name, uniqueness: :true

  WEEKDAY_HASH = {0 => "Sunday",
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday"}

  REVERSE_WEEKDAY_HASH = {
    :Sunday => 0,
    :Monday => 1,
    :Tuesday => 2,
    :Wednesday => 3,
    :Thursday => 4,
    :Friday => 5,
    :Saturday => 6
  }

  SHIFT_LENGTH_VALUES = [1, 2, 3, 4, 5, 6, 7]

  def start_day_as_string
    WEEKDAY_HASH[self.start_day]
  end

  def self.reverse_weekday_hash
    REVERSE_WEEKDAY_HASH
  end

  def self.shift_length_values
    SHIFT_LENGTH_VALUES
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

  def assignable_employee_hash
    employee_hash = {}
    team_list = self.assignable_employee_array
    team_list.each { |employee| employee_hash[employee.name] = employee.id }
    employee_hash
  end

  def events_by_date
    team_shift_ids = self.collect_shift_ids_by_team
    Day.where(shift_id: team_shift_ids, workday: true).group_by(&:value)
  end

  def upcoming_shifts_days
    days = Day.where("value > ?", Date.today)
    days.select { |day| day.shift.team === self }
  end

end
