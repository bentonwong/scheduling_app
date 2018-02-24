module TeamsHelper

  def team_employees_sorted_by(team)
    team.sorted_team_employees_by_id
  end

  def team_start_day_as_string(team)
    team.start_day_as_string
  end

  def weekday_names
    DayPreference.workday_list
  end

  def day_of_the_week(preference_day)
    DayPreference.weekday_key_value_name[preference_day]
  end

end
