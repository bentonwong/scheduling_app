require 'date'

class Shift < ApplicationRecord
  has_many :days, :dependent => :destroy
  belongs_to :team
  belongs_to :employee
  has_many :requests, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :days

  attr_accessor :assignment_method, :weeks_to_assign, :selected_date, :add_to_request, :response_shift_id

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
    upcoming_shifts_cache = team.upcoming_shifts_days.collect { |day| day.value }
    weeks_to_assign.times do
      new_shift = Shift.new
      new_shift.team = team
      !employee ? (new_shift.employee = team.assignable_employee_array.sample) : (new_shift.employee = employee)
      dates = self.find_next_open_dates(team, upcoming_shifts_cache)
      dates.each do |key, value|
        value.each do |day|
          holiday_status = Day.holiday?(day)
          key === :on ? (workday_status = !holiday_status) : (workday_status = false)
          new_shift.days.build(value: day, holiday: holiday_status, workday: workday_status)
          upcoming_shifts_cache << day
        end
      end
      new_shift.save
    end
  end

  def self.find_next_open_dates(team, cache)
    team_workdays = team.workday_values_array
    team_start_day = team_workdays.min
    next_start_day = Day.date_of_next(0)
    finalized = false
    while !finalized do
      proposed_shift_dates = []
      off_dates = []
      day = next_start_day
      7.times do
        if team_workdays.include?(day.wday)
          proposed_shift_dates << day
        else
          off_dates << day
        end
        day += 1
      end

      if proposed_shift_dates.all? { |date| !cache.include?(date) }
        finalized = true
      else
        next_start_day += 7
      end
    end
    {:on => proposed_shift_dates.sort, :off => off_dates.sort}
  end

  def get_shift_workdays
    self.days.select{ |day| day.workday }.sort_by{ |day| day.value }
  end

  def get_shift_days
    self.days.sort_by{ |day| day.value }
  end

  def get_potential_trades
    self.team.upcoming_shifts.select { |shift| shift != self && shift.employee != self.employee }
  end

  def started?
    self.get_shift_workdays.select { |day| day.workday }.any? { |day| day.value <= Date.today }
  end

  def ended?
    self.get_shift_workdays.select { |day| day.workday }.all? { |day| day.value < Date.today }
  end

  def get_start_end_day_values
    days = self.get_shift_workdays
    start_date, end_date = days.min_by(&:value), days.max_by(&:value)
    { :start => start_date.value, :end => end_date.value }
  end

  def responses_of_sent_request
    self.requests.detect { |request| request.status === 'sent' }.responses
  end

  def active_swap_requests?
    self.requests.any? { |request| request.status === 'sent' }
  end

  def active_swap_request
    self.requests.detect { |request| request.status === 'sent' }
  end

end
