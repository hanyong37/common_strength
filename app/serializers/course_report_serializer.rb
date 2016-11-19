class CourseReportSerializer < ActiveModel::Serializer
  attributes :id,
    :course_name,
    :course_type,
    :store_name,
    :from_date,
    :to_date,
    :total_capacity,
    :count_of_valid_booking,
    :count_of_absence,
    :count_of_complete,
    :count_of_be_late
end
