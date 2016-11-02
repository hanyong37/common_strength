class Training < ApplicationRecord

  before_save :check_customer_membership, if: "self.customer.measured_card?"
  after_save :change_customer_membership, if: "self.customer.measured_card?"
  belongs_to :customer
  belongs_to :schedule

  default_scope {joins(:schedule).order('start_time desc')}
  scope :valid_booking, -> {where('booking_status in (?)', %w/booked, no_booking, waiting_confirmed/ )}
  scope :by_schedule, ->(sch_id) {where('schedule_id = ?', sch_id) if (sch_id.present?)}
  scope :by_store, ->(str_id) {joins(:schedule).where('schedules.store_id = ?', str_id) if (str_id.present?)}
  scope :by_customer, ->(cst_id) {where('customer_id = ?', cst_id) if (cst_id.present?)}

  enum booking_status: {
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

  def store_id
    self.schedule.store_id
  end

  def store_name
    self.schedule.store_name
  end

  def is_started
    DateTime.now > self.start_time
  end

  def is_finished
    DateTime.now > self.end_time
  end

  def editable
    self.schedule.editable
  end

  def cancelable
    editable && ['booked','waiting_confirmed','waiting'].include?(self.booking_status)
  end

  def rebookable
    if self.customer.membership_type == 'measured_card'
      editable && ['cancelled'].include?(self.booking_status) && self.customer.membership_remaining_times >= 1 && (self.schedule.bookable || self.schedule.waitable)
    else
      editable && ['cancelled'].include?(self.booking_status) && (self.schedule.bookable || self.schedule.waitable)
    end
  end

  def cancel_or_rebook
    if cancelable
      self.update(booking_status: 'cancelled')
      schedule.change_queue
      return
    end

    self.update(booking_status: 'booked') and return if rebookable && schedule.bookable
    self.update(booking_status: 'waiting') and return if rebookable && schedule.waitable
  end

  private

  def check_customer_membership

    @membership_times_variance = 0

    old_booking_status = Training.find_by_id(self.id).booking_status
    old_training_status = Training.find_by_id(self.id).training_status

    @membership_times_variance = compare_booking_status(old_booking_status,self.booking_status) if self.changed.include? "booking_status"

    @membership_times_variance = compare_training_status(old_training_status, self.training_status) if self.changed.include? "training_status"

  end

  def change_customer_membership
    if @membership_times_variance != 0
      self.customer.membership_remaining_times += @membership_times_variance
      self.customer.save
    end
  end

  def compare_booking_status(old, new)
    watch_vars  = ['booked', 'waiting_confirmed']
    return 0 if old == new || (!watch_vars.include?(old) && !watch_vars.include?(new))
    return 1 if watch_vars.include?(old) && !watch_vars.include?(new)
    return -1 if !watch_vars.include?(old) && watch_vars.include?(new)
  end

  def compare_training_status(old, new)
    return 0 if old == new || (old != 'absence' && new != 'absence')
    return -1 if old == 'absence' && new != 'absence'
    return 1 if old != 'absence' && new == 'absence'
  end
end
