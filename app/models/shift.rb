class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee

  attr_accessor :assignment_method, :weeks_to_assign

  WEEKS_ARRAY = (1..10).to_a

  def create_new_shift(args)
    self.team = Team.find_by_id(args[:team_id])
    self.employee = Employee.find_by_id[:employee_id]

    days_array = []

    #1 get current date
    #2 find next start date
    #3 start instantiate from there and increment per spec

    self.days = days_array
    self
  end

  def self.weeks_array
    WEEKS_ARRAY
  end

  def self.assignable_employee_list(team_id)
    employee_list = {}
    team_list = Team.find_by_id(team_id).employees.select { |employee| employee.assignable }
    team_list.each { |employee| employee_list[employee.name] = employee.id }
    employee_list
  end

end
