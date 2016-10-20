class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :description, :type_id, :store_id, :default_capacity, :updated_at, :created_at
end
