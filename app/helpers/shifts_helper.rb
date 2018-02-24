require 'time'

module ShiftsHelper

  def concat_holidays(day)
    Day.get_holiday(day.value).collect {|holiday| holiday[:name]}.join(", ")
  end

  def get_shift_days(shift)
    shift.get_shift_days
  end

  def date_formatted(day)
    Day.format_date(day.value)
  end

  def get_day_of_the_week(day)
    day.get_day_of_the_week
  end

  def find_shift_by_id(id)
    Shift.find_by_id(id)
  end

end
