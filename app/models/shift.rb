class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee

end
