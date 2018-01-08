class Violation < ActiveRecord::Base
  has_many :inspection_violations
  has_many :inspections, through: :inspection_violations
  has_many :restaurants, through: :inspections
end
