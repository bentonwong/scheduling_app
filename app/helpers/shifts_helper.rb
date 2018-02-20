module ShiftsHelper

  def concat_holidays(day)
    Day.get_holiday(day.value).collect {|holiday| holiday[:name]}.join(", ")
  end

end
