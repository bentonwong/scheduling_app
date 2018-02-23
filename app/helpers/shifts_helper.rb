module ShiftsHelper

  def concat_holidays(day)
    Day.get_holiday(day.value).collect {|holiday| holiday[:name]}.join(", ")
  end

  def get_shift_days(shift)
    shift.get_shift_days
  end

  def date_formatted(day)
    day.value.strftime("%m/%d/%Y")
  end

  def get_day_of_the_week(day)
    day.get_day_of_the_week
  end

end
