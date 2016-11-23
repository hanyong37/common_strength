class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def self.time_range_of_a_day(date)
    Time.parse(date).beginning_of_day..Time.parse(date).end_of_day
  end

  def self.time_range_of_a_week(date)
    Time.parse(date).monday.beginning_of_day..Time.parse(date).sunday.end_of_day
  end

end
