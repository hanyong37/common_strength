class TrainingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :schedule_id, :booking_status, :training_status
  belongs_to :user
end
