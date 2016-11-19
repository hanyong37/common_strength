class CourseReport
  alias :read_attribute_for_serialization :send

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  attr_accessor :id,
    :course_name,
    :course_type,
    :store_name,
    :from_date,
    :to_date,
    :total_capacity,
    :count_of_valid_booking,
    :count_of_absence,
    :count_of_complete,
    :count_of_be_late

  def initialize(course_id, from_date, to_date)

    return nil if course_id.blank?
    course = Course.find_by_id course_id
    trainings = course.trainings.from_date(from_date).to_date(to_date).finished

    @id = course_id
    @course_name = course.name
    @store_name = course.store_name
    @course_type = course.type_name
    @from_date = from_date
    @to_date = to_date
    @total_capacity = trainings.sum('schedules.capacity')

    @count_of_valid_booking= trainings.valid_booking.size
    @count_of_absence = trainings.valid_booking.absence.size
    @count_of_complete = trainings.valid_booking.attended.size
    @count_of_be_late = trainings.valid_booking.be_late.size

  end

  def self.all(store_id, from_date, to_date)
    result = []
    Course.by_store(store_id).each do |cst|
      result << self.new(cst.id, from_date, to_date)
    end
    return result
  end
end
