class ScheduleOperationSerializer < ActiveModel::Serializer
  attributes :id, :schedule_id,   :bookable, :waitable, :booking_status, :schedule_reject_msg,:customer_id,:is_membership_valid,:customer_is_locked, :customer_membership_type, :customer_duedate, :customer_remainming_times, :customer_reject_msg
end
