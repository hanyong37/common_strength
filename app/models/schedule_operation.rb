class ScheduleOperation
  alias :read_attribute_for_serialization :send
  attr_accessor :id, :schedule_id, :customer_id, :is_membership_valid, :bookable, :waitable, :booking_status, :customer_membership_type, :customer_duedate, :customer_remainming_times

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  def initialize(schedule, customer)
    return nil if schedule.id.blank? || customer.id.blank?
    @id  = schedule.id.to_s+'_'+customer.id.to_s
    @schedule_id = schedule.id
    @customer_id = customer.id

    @bookable = schedule.bookable
    @waitable = schedule.waitable
    @booking_status = 'not_booked'

    @customer_membership_type = customer.membership_type
    @customer_duedate = customer.membership_duedate
    @customer_remainming_times = customer.membership_remaining_times

    if customer.is_locked
      @is_membership_valid = false
    else
      case @customer_membership_type
      when 'time_card'
        @is_membership_valid = @customer_duedate >= schedule.start_time.to_date
      when 'measured_card'
        @is_membership_valid = @customer_remainming_times >= 1
      else
        @is_membership_valid = false
      end
    end

    if schedule.trainings.exists? && !schedule.trainings.by_customer(customer.id).blank?
      @booking_status = schedule.trainings.by_customer(customer.id).first.booking_status
      @bookable = false
      @waitable = false
    end
  end
end
