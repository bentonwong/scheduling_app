class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    redirect_to team_path(@team)
  end

  def show
    @team = Team.find_by_id(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name, :start_day, :shift_length)
  end

end
