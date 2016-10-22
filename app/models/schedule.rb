class Schedule < ApplicationRecord
  validates :start_time, :end_time, :capacity, presence: :true
  belongs_to :course
  belongs_to :store
  has_many :trainings

  def store_name
    self.store.name
  end

  def course_name
    self.course.name
  end
end
