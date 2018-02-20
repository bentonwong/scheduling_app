module ShiftsHelper

  def concat_holidays(day)
    Holidays.on(day.value, :us, :ca).collect {|holiday| holiday[:name]}.join(", ")
  end

end
