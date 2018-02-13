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

  def start_day_as_string
    WEEKDAY_HASH[self.start_day]
  end

end
