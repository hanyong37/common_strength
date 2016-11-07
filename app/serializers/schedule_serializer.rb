class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_name, :course_id, :course_type_name,:course_name,:course_description, :start_time, :end_time, :capacity, :booked_number, :waiting_number, :cancelled_number , :is_published, :updated_at
end
