class Training < ApplicationRecord
  belongs_to :customer
  belongs_to :schedule

  scope :valid_booking, -> {where('booking_status in (?)', %w/booked, no_booking, waiting_confirmed/ )}
  scope :by_schedule, ->(sch_id) {where('schedule_id = ?', sch_id) if (sch_id.present?)}
  scope :by_store, ->(str_id) {joins(:schedule).where('schedules.store_id = ?', str_id) if (str_id.present?)}
  scope :by_customer, ->(cst_id) {find_by_customer_id(cst_id) if (cst_id.present?)}

  enum booking_status:{
    no_booking: -1,
    booked: 0,
    waiting: 1,
    waiting_confirmed: 2,
    cancelled: 3
  }

  enum training_status: {
    not_start: 0,
    absence: 1,
    be_late: 2,
    complete: 3
  }

  def customer_name
    self.customer.name
  end

  def start_time
    self.schedule.start_time
  end

  def end_time
    self.schedule.end_time
  end

  def course_id
    self.schedule.course_id
  end

  def course_name
    self.schedule.course_name
  end

  def store_name
    self.schedule.store_name
  end

  def store_id
    self.schedule.store_id
  end

end
