class Shift < ApplicationRecord
  has_many :days
  belongs_to :team
  belongs_to :employee

  attr_accessor :assignment_method, :weeks_to_assign

  WEEKS_ARRAY = (1..10).to_a

  def initialize
    
  end

  def self.weeks_array
    WEEKS_ARRAY
  end

end
