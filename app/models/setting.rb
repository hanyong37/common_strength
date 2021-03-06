class Setting < ApplicationRecord
  enum key: {
    booking_limit_days: 2,  #允许用户提前？天预定
    course_view_days: 3,    #允许用户查看？天的课程
    cancel_limit_minutes: 4,#允许用户提前？分钟可以取消，以及自动确认排队；
    queue_limit_number: 5 , #排队人数限制
    booking_limit_minutes: 1, #允许用户提前？分钟可以取消，以及自动确认排队；
    daily_booking_limit_number: 6 #每天允许的预约次数
  }

  def self.booking_limit_days
    Setting.find_or_create_by(key: :booking_limit_days).value.to_i
  end

  def self.booking_limit_days=(value)
    Setting.find_or_create_by(key: :booking_limit_days).update(value: value.to_s)
  end

  def self.course_view_days
    Setting.find_or_create_by(key: :course_view_days).value.to_i
  end

  def self.course_view_days=(value)
    Setting.find_or_create_by(key: :course_view_days).update(value: value.to_s)
  end

  def self.cancel_limit_minutes
    Setting.find_or_create_by(key: :cancel_limit_minutes).value.to_i
  end

  def self.cancel_limit_minutes=(value)
    Setting.find_or_create_by(key: :cancel_limit_minutes).update(value: value.to_s)
  end

  def self.queue_limit_number
    Setting.find_or_create_by(key: :queue_limit_number).value.to_i
  end

  def self.queue_limit_number=(value)
    Setting.find_or_create_by(key: :queue_limit_number).update(value: value.to_s)
  end

  def self.booking_limit_minutes
    Setting.find_or_create_by(key: :booking_limit_minutes).value.to_i
  end

  def self.booking_limit_minutes=(value)
    Setting.find_or_create_by(key: :booking_limit_minutes).update(value: value.to_s)
  end


  def self.daily_booking_limit_number
    Setting.find_or_create_by(key: :daily_booking_limit_number).value.to_i
  end

  def self.daily_booking_limit_number=(value)
    Setting.find_or_create_by(key: :daily_booking_limit_number).update(value: value.to_s)
  end

end
