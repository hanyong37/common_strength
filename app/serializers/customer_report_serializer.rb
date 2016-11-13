class CustomerReportSerializer < ActiveModel::Serializer
  attributes :id,
    :customer_name,
    :from_date,
    :to_date,
    :count_of_trainings,
    :count_of_waiting ,
    :count_of_waiting_confirmed ,
    :count_of_booked ,
    :count_of_no_booking,
    :count_of_cancelled,
    :count_of_not_start,
    :count_of_be_late,
    :count_of_complete,
    :count_of_absence,
    :favorite_time_slots,
    :favarite_courses
end
