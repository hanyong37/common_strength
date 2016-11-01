class ScheduleOperation
  alias :read_attribute_for_serialization :send
  attr_accessor :id, :schedule_id, :customer_id,  :bookable, :waitable, :booking_status

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  def initialize(schedule, customer)
    return nil if schedule.id.blank? || customer.id.blank?
    @id  = schedule.id
    @schedule_id = schedule.id
    @customer_id = customer.id

    @bookable = schedule.bookable
    @waitable = schedule.waitable
    @booking_status = 'not_booked'

    if schedule.trainings.exists? && !schedule.trainings.by_customer(customer.id).blank?
      @booking_status = schedule.trainings.by_customer(customer.id).booking_status
      @bookable = false
      @waitable = false
    end
  end
end
