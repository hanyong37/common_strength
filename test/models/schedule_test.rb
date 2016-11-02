require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'change queue' do
    Setting.queue_limit_number = 1
    schedule = schedules(:one)
    schedule.update(start_time: DateTime.now.advance(days:2), end_time: DateTime.now.advance(days:2))

    schedule.trainings.create(customer_id: customers(:ningmeng).id, booking_status: 'waiting', training_status: 'not_start')
    schedule.trainings.create(customer_id: customers(:dapeng).id, booking_status: 'waiting', training_status: 'not_start')

    assert schedule.trainings.booked.size == 1
    assert schedule.trainings.waiting.size == 2

    schedule.change_queue

    assert schedule.trainings.booked.size == 2
    assert schedule.trainings.waiting.size == 1
  end

  test 'test editable' do
    schedule = schedules(:one)
    schedule.update(start_time: DateTime.now.advance(days:2), end_time: DateTime.now.advance(days:2))
    assert schedule.editable
  end
end
