class CourseType < ApplicationRecord
  has_many :courses, foreign_key: 'type_id'
end
