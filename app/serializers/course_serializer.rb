class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :description, :type_id, :type_name, :store_id, :store_name, :default_capacity, :updated_at, :created_at
end
