module ScopeTool
  extend ActiveSupport::Concern

  scope :by_date , ->(date) { where("date(start_time) = ?", date) if date.present?}


end
