class TrainingSerializer < ActiveModel::Serializer
  attributes :id, :customer_id, :schedule_id, :booking_status, :training_status
  belongs_to :customer
end
