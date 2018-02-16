class CalendarController < ApplicationController
  def show
    def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Day.group_by(&:value)
  end
  end
end
