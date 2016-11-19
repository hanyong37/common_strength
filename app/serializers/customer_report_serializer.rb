class CustomerReportSerializer < ActiveModel::Serializer
  attributes :id,
    :customer_name,
    :store_name,
    :from_date,
    :to_date,
    :count_of_valid_booking,
    :count_of_absence,
    :count_of_complete,
    :count_of_be_late,
    :favorite_time_slots,
    :favarite_courses
end
