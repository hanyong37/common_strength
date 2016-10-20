class Course < ApplicationRecord
  validates :name, presence: :true
  belongs_to :type, class_name: 'CourseType'
  belongs_to :store
  has_many :schedules, dependent: :restrict_with_error

  enum status:{'active':1, 'inactive':0}
end
