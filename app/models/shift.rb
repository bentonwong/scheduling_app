require 'date'

class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee
  accepts_nested_attributes_for :days

  attr_accessor :assignment_method, :weeks_to_assign, :selected_date

  WEEKS_ARRAY = (1..10).to_a
  WEEKS_TO_ASSIGN_MANUAL = 1

  def self.weeks_array
    WEEKS_ARRAY
  end

  def self.create_shift(args)
    assignment_method, weeks_to_assign, employee_id, team_id = args.values_at(:assignment_method, :weeks_to_assign, :employee_id, :team_id)
    team = Team.find_by_id(team_id)
    if assignment_method === 'manual'
      employee = Employee.find_by_id(employee_id)
      self.set_shift_details(WEEKS_TO_ASSIGN_MANUAL, team, employee)
    else
      self.set_shift_details(weeks_to_assign.to_i, team)
    end
  end

  def self.set_shift_details(weeks_to_assign, team, employee=nil)
    upcoming_shifts_cache = Day.upcoming_shifts_by_team(team).collect {|day| day.value }
    weeks_to_assign.times do
      new_shift = Shift.new
      new_shift.team = team
      !employee ? (new_shift.employee = Employee.assignable_employee_array(team.id).sample) : (new_shift.employee = employee)
      open_dates = self.find_next_open_dates(team, upcoming_shifts_cache)
      open_dates.each do |day|
        holiday_status = Day.holiday?(day)
        new_shift.days.build(value: day, holiday: holiday_status, workday: !holiday_status)
        upcoming_shifts_cache << day
      end
      new_shift.save
    end
  end

  def self.find_next_open_dates(team, cache)
    team_start_day, shift_length, team_id = team.start_day, team.shift_length, team.id
    next_start_day = Day.date_of_next(team_start_day)
    finalized = false
    while !finalized do
      proposed_shift_dates = []
      day = next_start_day
      shift_length.times do
        proposed_shift_dates << day
        day += 1
      end
      if proposed_shift_dates.all? { |date| !cache.include?(date) }
        finalized = true
      else
        next_start_day += 7
      end
    end
    proposed_shift_dates.sort
  end

end
