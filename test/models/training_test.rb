require 'test_helper'

class TrainingTest < ActiveSupport::TestCase

  test 'change membership when training changes' do
    customers(:luochao).update(membership_type: 'measured_card', membership_total_times: 1)
    training = trainings(:one)
    #booking_status booked => cancelled
    assert_difference 'training.customer.reload.membership_remaining_times', 1 do
      training.update(booking_status: 'cancelled')
    end

    #booking_status cancelled => booked
    assert_difference 'training.customer.reload.membership_remaining_times', -1 do
      training.update(booking_status: 'booked')
    end

    #training_status not_start => absence
    assert_difference 'training.customer.reload.membership_remaining_times', 1 do
      training.update(training_status: 'absence')
    end

    #training_status absence => be_late
    assert_difference 'training.customer.reload.membership_remaining_times', -1 do
      training.update(training_status: 'be_late')
    end
  end

  test 'cancel or rebook' do
    #TODO :check change_queue is working.
    training = trainings(:one)
    training.schedule.update(:start_time => DateTime.now.advance(days: 2))
    assert training.booking_status = 'booked'
    assert training.cancelable

    training.cancel_or_rebook
    assert training.booking_status = 'cancelled'
    assert training.rebookable

    training.cancel_or_rebook
    assert training.booking_status = 'booked'
    assert training.cancelable

    #test for measured_card
    training.customer.update(membership_type:  "measured_card", membership_total_times: 10)
    training.cancel_or_rebook
    assert training.booking_status = 'cancelled'
    assert training.rebookable

  end

  test 'can\'t create training for same customer and same schedule' do
    newTraining = trainings(:one).dup
    assert_not newTraining.save
    assert newTraining.errors.first.include? :customer
    assert newTraining.errors.first.include? 'has already been taken'
  end
end

