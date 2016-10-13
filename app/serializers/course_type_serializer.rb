class CourseTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :courses
end
