class Response < ApplicationRecord
  belongs_to :request
  belongs_to :employee
  belongs_to :shift

end
