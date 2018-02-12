class Employee < ApplicationRecord
  has_many :team_employees
  has_many :requests
  has_many :shifts

end
