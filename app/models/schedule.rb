class Schedule < ApplicationRecord
  validates :start_time, :end_time, :capacity, presence: :true

  belongs_to :course
  belongs_to :store
  has_many :trainings, dependent: :restrict_with_error
  has_many :customers, through: :trainings, dependent: :restrict_with_error

  scope :by_store , ->(store) {where(store_id: store) if store.present?}
  scope :by_date , ->(date) { where("date(start_time) = ?", date) if date.present?}
  scope :by_week , ->(monday_date) { where("date(start_time) >= ? and date(start_time) <= ?", monday_date, monday_date+6.days) if monday_date.present?}
  scope :viewable , -> {where("is_published = ? and date(start_time) < ?",true, Date.today.advance(days: Setting.course_view_days.days))}
  #scope :published, -> {where(is_published:true)}

  def store_name
    self.store.name
  end

  def course_type_name
    course.type.name
  end

  def course_description
    course.description
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

  def bookable
    editable  && in_capacity
  end

  def waitable
    editable && !in_capacity && in_queue_limit_number
  end

  def editable
    in_booking_limit_days && in_cancel_limit_minutes
  end


  def change_queue
    if in_cancel_limit_minutes
      queue = self.trainings.waiting.order(:created_at)
      queue.first.update(booking_status: 'booked') and return true unless queue.blank?
    end
      return false
  end

  private
  def in_booking_limit_days
    self.start_time.to_date <= Date.today+Setting.booking_limit_days.days
  end

  def in_cancel_limit_minutes
    DateTime.now.advance(minutes: Setting.cancel_limit_minutes) < self.start_time
  end

  def in_queue_limit_number
    self.trainings.waiting.size < Setting.queue_limit_number
  end

  def in_capacity
    self.trainings.valid_booking.count < self.capacity
  end


end
