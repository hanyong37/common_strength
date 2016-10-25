class OperationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_name, :customer_id, :customer_name,   :description, :operation_memo,:created_at
end
