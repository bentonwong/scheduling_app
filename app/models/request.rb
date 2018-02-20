class Request < ApplicationRecord
  belongs_to :employee
  belongs_to :shift
  has_many :responses
  accepts_nested_attributes_for :responses

end
