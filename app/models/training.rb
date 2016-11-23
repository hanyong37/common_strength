class Training < ApplicationRecord
  validates_uniqueness_of :customer, scope: :schedule

  belongs_to :customer
  belongs_to :schedule

  #before_save :check_customer_membership, if: "self.customer.measured_card?"
  #after_save :change_customer_membership, if: "self.customer.measured_card?"
  after_destroy_commit :check_queue

  scope :by_schedule, ->(sch_id) {where('schedule_id = ?', sch_id) if (sch_id.present?)}
  scope :by_store, ->(str_id) {joins(:schedule).where('schedules.store_id = ?', str_id) if (str_id.present?)}
  scope :by_customer, ->(cst_id) {where('customer_id = ?', cst_id) if (cst_id.present?)}
  scope :from_date, ->(from){where(" schedules.start_time >= ?",Time.parse(from).beginning_of_day) if (from.present?)}
  scope :to_date, ->(to){where("schedules.start_time <= ?", Time.parse(to).end_of_day) if (to.present?)}

  scope :time_desc, -> {joins(:schedule).order('schedules.start_time desc')}
  scope :time_asc, -> {joins(:schedule).order('schedules.start_time asc')}

  scope :valid_booking, -> {where('booking_status in (?)',
                                  [booking_statuses[:booked],
                                   booking_statuses[:no_booking]])}

  scope :attended, ->{where("training_status <> ?", training_statuses[:absence]) }

  scope :finished, ->{joins(:schedule).where("schedules.end_time < ?", DateTime.now) }
  scope :not_started, ->{joins(:schedule).where("schedules.end_time >= ?", DateTime.now) }

  #客户预约后为booked
  #客户取消后删除记录
  #客户排队后为waiting，排队成功为booked
  #由管理员录入的为no_booking
  enum booking_status: {
    no_booking: -1,
    booked: 0,
    waiting: 1
    #waiting_confirmed: 2,
    #cancelled: 3
  }

  #normal: 课程结束后默认为完成
  #absence: 缺席课程
  #be_late: 迟到
  enum training_status: {
    normal: 0,
    absence: 1,
    be_late: 2
    #complete: 3
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

  def readable_status
    if schedule.time_stage == 'finished'
      return '课程已完成' if normal? && !waiting?
      return '排队失败' if normal? && waiting?
      return '课程迟到' if be_late?
      return '缺席' if absence?
      return '数据错误'
    elsif schedule.time_stage == 'ongoing'
      return '排队失败' if waiting?
      return '课程进行中'
    else #not_started
      return '您已预约' if booked?
      return '您已排队' if waiting?
      return '门店已帮你预约' if no_booking?
      return '数据错误'
    end

  end

  def is_completed
    !(absence? && waiting?) && schedule.is_finished
  end

  def cancelable
     ['no_booking','booked','waiting'].include?(booking_status) && schedule.cancelable
  end


  private

  def check_queue
    if schedule.cancelable
      number = schedule.capacity - schedule.booked_number
      if number > 0 && schedule.waiting_number > 0
        number.times do
          schedule.trainings.waiting.time_asc.first.update(booking_status: 'booked')
        end
      end
    end
  end

  #def rebookable
  #  if self.customer.membership_type == 'measured_card'
  #    editable && ['cancelled'].include?(self.booking_status) && self.customer.membership_remaining_times >= 1 && (self.schedule.bookable || self.schedule.waitable)
  #  else
  #    editable && ['cancelled'].include?(self.booking_status) && (self.schedule.bookable || self.schedule.waitable)
  #  end
  #end

  #def cancel_or_rebook
  #  if cancelable
  #    self.update(booking_status: 'cancelled')
  #    schedule.change_queue
  #    return
  #  end

  #  self.update(booking_status: 'booked') and return if rebookable && schedule.bookable
  #  self.update(booking_status: 'waiting') and return if rebookable && schedule.waitable
  #end


#  def check_customer_membership
#
#    @membership_times_variance = 0
#
#    #区分新增和修改
#    if self.id
#      old_booking_status = Training.find_by_id(self.id).try(:booking_status)
#      old_training_status = Training.find_by_id(self.id).try(:training_status)
#
#      @membership_times_variance = compare_booking_status(old_booking_status,self.booking_status) if self.changed.include? "booking_status"
#      @membership_times_variance = compare_training_status(old_training_status, self.training_status) if self.changed.include? "training_status"
#    else
#      @membership_times_variance = -1
#    end
#  end
#
#  def change_customer_membership
#    if @membership_times_variance != 0
#      self.customer.membership_remaining_times += @membership_times_variance
#      self.customer.save
#    end
#  end
#
#  def compare_booking_status(old, new)
#    watch_vars  = ['booked', 'waiting_confirmed']
#    return 0 if old == new || (!watch_vars.include?(old) && !watch_vars.include?(new))
#    return 1 if watch_vars.include?(old) && !watch_vars.include?(new)
#    return -1 if !watch_vars.include?(old) && watch_vars.include?(new)
#  end
#
#  def compare_training_status(old, new)
#    return 0 if old == new || (old != 'absence' && new != 'absence')
#    return -1 if old == 'absence' && new != 'absence'
#    return 1 if old != 'absence' && new == 'absence'
#  end



end
