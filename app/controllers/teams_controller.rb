class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    raise params.inspect
  end

  private

  def team_params
    params.require(:team).permit(:name, :start_day, :shift_length)
  end

end
