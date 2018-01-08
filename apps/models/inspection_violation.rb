class InspectionViolation < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :violation

end
