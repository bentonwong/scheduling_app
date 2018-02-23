module TeamsHelper

  def team_employees_sorted_by(team)
    team.sorted_team_employees_by_id
  end

  def team_start_day_as_string(team)
    team.start_day_as_string
  end

end
