require 'test_helper'

class Weixin::ScheduleOperationsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    Setting.booking_limit_days = 3
    @schedule_new = Schedule.create(course_id: courses(:one).id,
                                    store_id: stores(:one).id,
                                    capacity: 10,
                                    start_time: DateTime.now+1.days,
                                    end_time: DateTime.now+60.minutes,
                                    is_published:false)
  end

  test "404 for nonexisting schedule" do
    get '/weixin/schedules/0000009/schedule_operations', headers: weixin_auth_header
    assert_response :not_found
  end

  test "403 for unpublished schedule" do
    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header

    assert_response :forbidden
  end

  test "bookable if in capacity" do
    @schedule_new.update(is_published: true)
    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['bookable']
    assert_not jresponse['data']['attributes']['waitable']

    assert_not jresponse['data']['attributes']['is_membership_valid']
  end

  test "test customer timecard" do
    @schedule_new.update(is_published: true)
    customers(:luochao).update(membership_type: 'time_card' , membership_duedate: Date.today.advance(days: 10))

    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header

    assert_response :success
    assert jresponse['data']['attributes']['is-membership-valid']
  end

  test "test customer measured_card" do
    @schedule_new.update(is_published: true)
    customers(:luochao).update(membership_type: 'measured_card' , membership_total_times: 0)

    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header

    assert_response :success
    assert_not jresponse['data']['attributes']['is-membership-valid']
  end

  test "test customer no type" do
    @schedule_new.update(is_published: true)
    customers(:luochao).update(membership_type: nil)

    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header

    assert_response :success
    assert_not jresponse['data']['attributes']['is-membership-valid']
  end

  test "waitable if in queue limit" do
    @schedule_new.update(is_published: true)
    @schedule_new.update(capacity: 0)
    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header
    assert_response :success
    assert_not jresponse['data']['attributes']['bookable']
    assert jresponse['data']['attributes']['waitable']
  end

  test "refuse if out capacity and queue limit" do
    @schedule_new.update(is_published: true)
    @schedule_new.update(capacity: 0)
    Setting.queue_limit_number = 0
    get '/weixin/schedules/'+@schedule_new.id.to_s+'/schedule_operations', headers: weixin_auth_header
    assert_response :success
    assert_not jresponse['data']['attributes']['bookable']
    assert_not jresponse['data']['attributes']['waitable']
  end

  test "can't book or wait if daily_booking_limit_number reached" do
    @schedule_new.update(is_published: true)
    Setting.daily_booking_limit_number = 1
    Training.create(schedule_id: @schedule_new.id, customer_id: customers(:luochao).id, booking_status: 'booked', training_status:'normal')
    @schedule_2 = @schedule_new.dup
    @schedule_2.save
    get '/weixin/schedules/'+@schedule_2.id.to_s+'/schedule_operations', headers: weixin_auth_header
    assert_response :success
    assert_not jresponse['data']['attributes']['bookable']
    assert_not jresponse['data']['attributes']['schedule_reject_msg'] == '同一天只能预约1个课程！'

  end

end
