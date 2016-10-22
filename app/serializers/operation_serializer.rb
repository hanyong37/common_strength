class OperationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :customer_id,  :description, :operation_memo,:created_at
end
