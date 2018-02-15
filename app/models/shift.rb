require 'date'

class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee

  attr_accessor :assignment_method, :weeks_to_assign

  WEEKS_ARRAY = (1..10).to_a

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

  def self.create_new_shifts(args)
    assignment_method, weeks_to_assign, employee_id, team_id = args.values_at(:assignment_method, :weeks_to_assign, :employee_id, :team_id)

    team = Team.find_by_id(team_id)
    employee = Employee.find_by_id(employee_id)

    if assignment_method === 'manual'
      employee = Employee.find_by_id(employee_id)
      new_shift = self.assign_shift(1, team, employee)
    else
      new_shift = self.assign_shift(weeks_to_assign, team)
    end
  end

  def self.assign_shift(weeks_to_assign, team, employee=nil)
    weeks_to_assign.times do
      new_shift = Shift.new
      new_shift.team = team
      if !employee
        new_shift_employee = assignable_employee_array(team.id).sample
      else
        new_shift.employee = employee
      end
      self.set_shift_dates(team).each do |day|
        new_shift.days.build(value: day, holiday: Day.holiday?(day))
      end
      new_shift.save
    end
  end

  def self.set_shift_dates(team)
    team_start_day, shift_length, team_id = team.start_day, team.shift_length, team.id

    next_start_day = Day.date_of_next(team_start_day)

    proposed_shift_days = []

    shift_length.times do
      proposed_shift_days << next_start_day
      next_start_day += 1
    end

    #do the overlap check at this point
    #if overlap, then update next_start_date to following week
    #else break out of loop
    
    #3 - check if proposed shift dates overlaps any current or upcoming shifts [an array]

    proposed_shift_days
  end

end
