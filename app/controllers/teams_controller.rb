class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]
  before_action :import_weekday_hash, only: [:new, :edit]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.save ? (redirect_to team_path(@team)) : (redirect_to new_team_path)
  end

  def show
  end

  def edit
  end

  def update
    @team.update(team_params)
    redirect_to @team
  end

  private

    def team_params
      params.require(:team).permit(:name, :start_day, :shift_length)
    end

    def set_team
      @team = Team.find_by_id(params[:id])
    end

    def import_weekday_hash
      @weekdays = Team.reverse_weekday_hash
      @shift_length_values = Team.shift_length_values
    end

end
