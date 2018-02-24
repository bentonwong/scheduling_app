class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]
  before_action :authorized?
  before_action :employee_authorized?

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
    @team.save ? (redirect_to team_path(@team)) : (render :action => 'new')
  end

  def show
  end

  def edit
  end

  def update
    @team.update(team_params)
    @team.save ? (redirect_to @team) : (render :action => 'edit')
  end

  private

    def team_params
      params.require(:team).permit(:name, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end

    def set_team
      @team = Team.find_by_id(params[:id])
    end

end
