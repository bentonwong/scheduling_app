class ShiftsController < ApplicationController

  def index
    @shifts = Shift.all
  end

end
