class Course < ApplicationRecord
  belongs_to :type, class_name: 'CourseType'
end
