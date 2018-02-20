class Day < ApplicationRecord
  belongs_to :shift

  def get_day_of_the_week
    self.value.strftime('%A')
  end

  def get_holiday_text
    Day.get_holiday(self.value).collect {|holiday| holiday[:name]}.join(", ")
  end

  def self.get_holiday(day)
    Holidays.on(day, :us, :ca)
  end

  def self.holiday?(day)
    self.get_holiday(day).length > 0
  end

  def self.date_of_next(day)
    date = Date.parse(Date::DAYNAMES[day])
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  def self.upcoming_shifts_days_by_team(team)
    days = self.where("value > ?", Date.today)
    days.select { |day| day.shift.team === team }
  end

end
