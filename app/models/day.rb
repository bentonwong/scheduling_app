class Day < ApplicationRecord
  belongs_to :shift

  def self.holiday?(day)
    Holidays.on(day, :us, :ca).length > 0
  end

  def self.date_of_next(day)
    date = Date.parse(Date::DAYNAMES[day])
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  def self.upcoming_shifts_by_team(team)
    days = self.where("value > ?", Date.today)
    days.select { |day| day.shift.team === team }
  end

end
