class TrainingSerializer < ActiveModel::Serializer
  attributes :id,
    :store_id,
    :store_name,
    :customer_id,
    :customer_name,
    :schedule_id,
    :start_time,
    :end_time ,
    :course_id,
    :course_name,
    :booking_status,
    :training_status,
    :cancelable,
    :created_at,
    :readable_status,
    :updated_at
end
