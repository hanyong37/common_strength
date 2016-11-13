class CustomerReport
  alias :read_attribute_for_serialization :send

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  attr_accessor :id,
    :customer_name,
    :from_date,
    :to_date,
    :count_of_trainings,
    :count_of_waiting ,
    :count_of_waiting_confirmed ,
    :count_of_booked ,
    :count_of_no_booking,
    :count_of_cancelled,
    :count_of_not_start,
    :count_of_be_late,
    :count_of_complete,
    :count_of_absence,
    :favorite_time_slots,
    :favarite_courses

  def initialize(customer_id, from_date, to_date)

    return nil if customer_id.blank?
    customer = Customer.find_by_id customer_id
    trainings = customer.trainings.from_date(from_date).to_date(to_date)

    @id = customer_id
    @customer_name = customer.name
    @from_date = from_date
    @to_date = to_date
    @count_of_trainings = trainings.size
    #booking status
    @count_of_booked = trainings.booked.size
    @count_of_no_booking = trainings.no_booking.size
    @count_of_waiting = trainings.waiting.size
    @count_of_waiting_confirmed = trainings.waiting_confirmed.size
    @count_of_cancelled = trainings.cancelled.size
    #training status
    @count_of_not_start =trainings.not_start.size
    @count_of_be_late = trainings.be_late.size
    @count_of_absence = trainings.absence.size
    @count_of_complete = trainings.complete.size
    @favorite_time_slots = customer.favorite_time_slots
    @favarite_courses = customer.favarite_courses
  end

  def self.all(from_date, to_date)
    crs = []
    Customer.all.each do |cst|
      crs << self.new(cst.id, from_date, to_date)
    end
    return crs
  end
end
