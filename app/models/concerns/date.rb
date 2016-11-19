module ScopeByStore
  extend ActiveSupport::Concern
  included do
    scope :by_store, ->(str_id) {joins(:schedule).where('schedules.store_id = ?', str_id) if (str_id.present?)}
  end
end
