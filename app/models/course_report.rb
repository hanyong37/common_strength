class CourseReport
  alias :read_attribute_for_serialization :send

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  attr_accessor :id,
    :course_name,
    :store_id,
    :store_name,
    :course_type,
    :from_date,
    :to_date,
    :total_capacity,
    :count_of_trainings,
    :count_of_waiting ,
    :count_of_waiting_confirmed ,
    :count_of_booked ,
    :count_of_no_booking,
    :count_of_cancelled,
    :count_of_not_start,
    :count_of_be_late,
    :count_of_complete,
    :count_of_absence

  def initialize(course_id, from_date, to_date)

    return nil if course_id.blank?
    course = Course.find_by_id course_id
    trainings = course.trainings.from_date(from_date).to_date(to_date)

    @id = course_id
    @course_name = course.name
    @store_id = course.store_id
    @store_name = course.store_name
    @course_type = course.type_name
    @from_date = from_date
    @to_date = to_date
    @total_capacity = trainings.sum('schedules.capacity')
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
  end

  def self.all(from_date, to_date)
    result = []
    Course.all.each do |cst|
      result << self.new(cst.id, from_date, to_date)
    end
    return result
  end
end
