class ScheduleOperationSerializer < ActiveModel::Serializer
  attributes :booking_status, :id, :schedule_id, :bookable, :waitable, :customer_id,:is_membership_valid, :customer_membership_type, :customer_duedate, :customer_remainming_times
end
