class CourseType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :courses, foreign_key: 'type_id', dependent: :restrict_with_error
end
