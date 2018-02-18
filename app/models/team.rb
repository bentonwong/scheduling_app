class Team < ApplicationRecord
  has_many :shifts
  has_many :team_employees
  has_many :employees, through: :team_employees

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

  def collect_shift_ids_by_team
    self.shifts.collect { |shift| shift.id }.uniq
  end

  def start_day_as_string
    WEEKDAY_HASH[self.start_day]
  end

  def sorted_team_employees_by_id
    self.employees.sort_by{ |employee| employee.id }
  end

  def current_shift
    Day.upcoming_shifts_by_team(self).first
  end

  def next_shift
    Day.upcoming_shifts_by_team(self)[1]
  end

  def self.reverse_weekday_hash
    REVERSE_WEEKDAY_HASH
  end

  def self.shift_length_values
    SHIFT_LENGTH_VALUES
  end

end
