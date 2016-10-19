class Course < ApplicationRecord
  belongs_to :type, class_name: 'CourseType'
  belongs_to :stores
end
