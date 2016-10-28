class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_name, :course_id, :course_name, :start_time, :end_time, :capacity, :is_published, :updated_at, :booked_number
end
