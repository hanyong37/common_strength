class Schedule < ApplicationRecord
  validates :start_time, :end_time, :capacity, presence: :true

  belongs_to :course
  belongs_to :store
  has_many :trainings, dependent: :restrict_with_error
  has_many :customers, through: :trainings, dependent: :restrict_with_error

  scope :by_store , ->(store) {where(store_id: store) if store.present?}
  scope :by_course , ->(course) {where(course_id: course) if course.present?}
  scope :by_date , ->(date) { where(start_time: time_range_of_a_day(date)) if date.present?}

  scope :by_week , ->(date) { where(start_time: time_range_of_a_week(date)) if date.present?}

  scope :viewable , -> {where("is_published = ? and start_time <= ?", true, DateTime.now.yesterday.end_of_day.advance(days: Setting.course_view_days))}
  scope :time_asc, ->{order(start_time: :asc)}
  #scope :published, -> {where(is_published:true)}


  def store_name
    store.name
  end

  def course_type_name
    course.type.name
  end

  def course_description
    course.description
  end

  def course_name
    course.name
  end

  #以下为状态字段
  def booked_number
    trainings.valid_booking.size
  end

  def waiting_number
    trainings.waiting.size
  end

  def complete_number
    trainings.finished.valid_booking.attended.size
  end

  def bookable
    in_capacity && in_booking_limit_days && in_booking_limit_minutes
  end

  def waitable
    !in_capacity && in_queue_limit_number && in_booking_limit_days && in_booking_limit_minutes
  end

  def cancelable
    in_cancel_limit_minutes
  end

  def time_stage
    if DateTime.now >= end_time
      return 'finished'
    elsif DateTime.now >= start_time && DateTime.now < end_time
      return 'ongoing'
    else
      return 'not_started'
    end
  end

  def reject_msg
    unless bookable || waitable
      return '课程还未开放预约！' unless in_booking_limit_days
      return "课程已经无法预约！" unless in_booking_limit_minutes
      return "报名人数已满，下次早点来哦！" unless in_capacity || in_queue_limit_number
    else
      return ""
    end
  end


  private

  def in_cancel_limit_minutes
    DateTime.now.advance(minutes: Setting.cancel_limit_minutes) < start_time
  end

  def in_booking_limit_days
    start_time <= Time.now.yesterday.end_of_day.advance(days: Setting.booking_limit_days)
  end

  def in_booking_limit_minutes
    DateTime.now.advance(minutes: Setting.booking_limit_minutes) < start_time
  end

  def in_queue_limit_number
    trainings.waiting.size < Setting.queue_limit_number
  end

  def in_capacity
    trainings.valid_booking.count < capacity
  end

end
