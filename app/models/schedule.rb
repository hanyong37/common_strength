class Schedule < ApplicationRecord
  validates :start_time, :end_time, :capacity, presence: :true
  belongs_to :course
  belongs_to :store
  has_many :trainings, dependent: :restrict_with_error

  scope :by_store , ->(store) {where(store_id: store) if store.present?}
  scope :by_date , ->(date) { where("date(start_time) = ?", date) if date.present?}
  scope :viewable , -> {where("date(start_time) < ?", Date.today+Setting.course_view_days.to_i.days)}
  scope :published, -> {where(is_published:true)}

  def store_name
    self.store.name
  end

  def course_name
    self.course.name
  end

  def booked_number
    self.trainings.where.not(booking_status: :cancelled).count
  end

  def waiting_number
    self.trainings.waiting.count
  end

  def cancelled_number
    self.trainings.cancelled.count
  end
end
