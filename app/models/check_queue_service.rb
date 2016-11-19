class CheckQueueService
  def initialize(schedule)
    space = schedule.capacity - schedule.booked_number
    if space > 0 && schedule.waiting_number > 0
      space.times do
        schedule.trainings.waiting.time_asc.first.update(booking_status: 'booked')
      end
    end
  end
end
