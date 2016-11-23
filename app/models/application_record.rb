class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  START_DATE_IN_CST = " date(schedules.start_time AT TIME ZONE 'utc') ".freeze
end
