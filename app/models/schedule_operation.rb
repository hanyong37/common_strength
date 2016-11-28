class ScheduleOperation
  alias :read_attribute_for_serialization :send
  attr_accessor :id,
    :schedule_id,
    :customer_id,
    :is_membership_valid,
    :bookable,
    :waitable,
    :cancelable,
    :cancel_id,
    :booking_status,
    :schedule_reject_msg,
    :customer_is_locked,
    :customer_membership_type,
    :customer_duedate,
    :customer_remainming_times,
    :customer_reject_msg

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  def initialize(schedule, customer)

    return nil if schedule.id.blank? || customer.id.blank?

    @id  = schedule.id.to_s+'_'+customer.id.to_s
    @schedule_id = schedule.id
    @customer_id = customer.id
    @cancelable = false
    @cancel_id = -1



    #check customer availability
    @customer_is_locked = customer.is_locked
    @customer_membership_type = customer.membership_type
    @customer_duedate = customer.membership_duedate
    @customer_remainming_times = customer.membership_remaining_times

    @customer_reject_msg = ""

    if customer.is_locked
      @is_membership_valid = false
      @customer_reject_msg = '您的会员卡已被锁定！'
    else
      case @customer_membership_type
      when 'time_card'
        @is_membership_valid = @customer_duedate >= schedule.start_time.to_date
        @customer_reject_msg = '您的会员卡已经到期！' unless @is_membership_valid
      when 'measured_card'
        @is_membership_valid = @customer_remainming_times >= 1
        @customer_reject_msg = '您已经没有可用的预约次数了！' unless @is_membership_valid
      else
        @is_membership_valid = false
      end

    end

    #check schedule availability

    if Training.where(schedule_id: schedule.id, customer_id: customer_id).any?
      @booking_status = Training.where(schedule_id: schedule.id, customer_id: customer_id).first.booking_status
      @bookable = false
      @waitable = false
      @schedule_reject_msg = '已预约，现无法取消！'
      @cancelable = schedule.cancelable
      @cancel_id = Training.where(schedule_id: schedule.id, customer_id: customer_id).first.id if @cancelable
    elsif not  in_daily_booking_limit_number
      @schedule_reject_msg = "同一天只能预约#{Setting.daily_booking_limit_number}个课程！"
      @bookable = false
      @waitable = false
    else
      @booking_status = 'not_booked'
      @bookable = schedule.bookable
      @waitable = schedule.waitable
      @schedule_reject_msg = schedule.reject_msg
    end
  end

    private

    def in_daily_booking_limit_number
      check_date = Schedule.find(@schedule_id).start_time.localtime.to_date.to_s
      Training.joins(:schedule).by_customer(@customer_id).from_date(check_date).to_date(check_date).size < Setting.daily_booking_limit_number
    end

end
