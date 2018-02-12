class Team < ApplicationRecord
  has_many :shifts
  has_many :team_employees

end
