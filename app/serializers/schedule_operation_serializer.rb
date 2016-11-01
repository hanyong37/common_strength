class ScheduleOperationSerializer < ActiveModel::Serializer
  attributes :id, :schedule_id, :customer_id,:booking_status, :bookable, :waitable
end
