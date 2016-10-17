class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :description, :type_id, :store_id, :updated_at
end
