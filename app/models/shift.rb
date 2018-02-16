require 'date'

class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee

  attr_accessor :assignment_method, :weeks_to_assign, :selected_date

  WEEKS_ARRAY = (1..10).to_a
  WEEKS_TO_ASSIGN_MANUAL = 1

  def self.weeks_array
    WEEKS_ARRAY
  end

  def self.assignable_employee_array(team_id)
    Team.find_by_id(team_id).employees.select { |employee| employee.assignable }
  end

  def self.assignable_employee_hash(team_id)
    employee_hash = {}
    team_list = self.assignable_employee_array(team_id)
    team_list.each { |employee| employee_hash[employee.name] = employee.id }
    employee_hash
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
      !employee ? (new_shift.employee = assignable_employee_array(team.id).sample) : (new_shift.employee = employee)
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

  def collect_days
    self.days.collect {|day| day.value }
  end

  def select_holidays
    self.days.select{|day| day.holiday }.collect {|day| day.value }
  end

  def self.current_and_upcoming_shifts(n)
    results = {}
    upcoming_shifts = self.joins(:days).where("days.value >= ?", Date.today).uniq
    upcoming_shifts.each do |shift|
      dates_array = shift.days.collect do |day|
        day.value
      end
      results[shift.id] = dates_array.sort.first
    end
    next_n_shifts_start_dates_ids = results.sort_by {|key, value| value}[0..n-1]
    next_n_shifts_ids = next_n_shifts_start_dates_ids.collect { |shift| shift.first }
    next_n_shifts_ids.collect { |id| Shift.find_by_id(id) }
  end

end
