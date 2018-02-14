class ShiftsController < ApplicationController
  before_action :authorized?

  def index
    @shifts = Shift.all
  end

end
