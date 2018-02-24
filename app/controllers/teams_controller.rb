class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]
  before_action :authorized?
  before_action :employee_authorized?
  before_action :set_workday_prefs, only: [:create, :update]
  before_action :get_workday_prefs, only: [:edit]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params) do |u|
      u.workday_prefs = @workday_prefs
    end
    @team.save ? (redirect_to team_path(@team)) : (render :action => 'new')
  end

  def show
    get_workday_prefs
  end

  def edit
  end

  def update
    @team.update(team_params)
    @team.update_attribute(:workday_prefs, @workday_prefs)
    @team.save ? (redirect_to team_path(@team)) : (render :action => 'edit')
  end

  private

    def team_params
      params.require(:team).permit(:id, :name, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end

    def set_team
      @team = Team.find_by_id(params[:id])
    end

    def set_workday_prefs
      @workday_prefs = Team.days_of_the_week.collect { |day| team_params[day] === "1" ? 1 : 0 }.join(',')
    end

    def get_workday_prefs
      workday_prefs = @team.split_workday_prefs
      Team.days_of_the_week.each_with_index do |day, index|
        workday_prefs[index] === "1" ? @team.send("#{day}=", true) : @team.send("#{day}=", false)
      end
    end

end
