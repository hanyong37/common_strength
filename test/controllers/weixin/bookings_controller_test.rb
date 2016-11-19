require 'test_helper'

class Weixin::BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule_new = Schedule.create(course_id: courses(:one).id,
                                    store_id: stores(:one).id,
                                    capacity: 10,
                                    start_time: DateTime.now+1.days,
                                    end_time: DateTime.now+60.minutes,
                                    is_published:true)
    customers(:luochao).update(membership_type: 'time_card', membership_duedate: Date.today.advance(years:1))
  end

  test "200 for success" do
    assert_difference '@schedule_new.reload.trainings.size', 1 do
      post '/weixin/schedules/'+@schedule_new.id.to_s+'/booking', headers: weixin_auth_header
    end
    assert_response :success
  end

  test "200 for success for measured_card" do
    customers(:luochao).update(membership_type: 'measured_card', membership_total_times: 3)
    assert_difference '@schedule_new.reload.trainings.size', 1 do
      post '/weixin/schedules/'+@schedule_new.id.to_s+'/booking', headers: weixin_auth_header
    end
    assert_response :success
  end

  test "409 for existing training" do
      @schedule_new.trainings.create(customer_id: customers(:luochao).id,
                                     booking_status: 'waiting',
                                     training_status: 'not_start')
    assert_no_difference '@schedule_new.reload.trainings.size' do
      post '/weixin/schedules/'+@schedule_new.id.to_s+'/booking', headers: weixin_auth_header
    end
    assert_response :conflict
  end

  test "200 and create waiting" do
    @schedule_new.update(capacity:1)
    Setting.queue_limit_number = 1
    @schedule_new.trainings.create(customer_id: customers(:ningmeng).id,
                                   booking_status: 'booked',
                                   training_status: 'not_start')
    post '/weixin/schedules/'+@schedule_new.id.to_s+'/booking', headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['booking-status'] == 'waiting'
  end
  test "404 for notfound" do
    post '/weixin/schedules/101001/booking', headers: weixin_auth_header
    assert_response :not_found
  end

  test "403 for forbidden schedule" do
    schedule_of_other_store = Schedule.create(course_id: courses(:one).id,
                                              store_id: stores(:two).id,
                                              capacity: 10,
                                              start_time: DateTime.now+1.days,
                                              end_time: DateTime.now+60.minutes,
                                              is_published:true)
    post '/weixin/schedules/'+schedule_of_other_store.id.to_s+'/booking', headers: weixin_auth_header
    assert_response :forbidden
  end

  test "409 for conflict" do
    @schedule_new.update(capacity:1)
    Setting.queue_limit_number = 0
    @schedule_new.trainings.create(customer_id: customers(:ningmeng).id,
                                   booking_status: 'booked',
                                   training_status: 'not_start')
    post '/weixin/schedules/'+@schedule_new.id.to_s+'/booking', headers: weixin_auth_header
    assert_response :conflict
  end

end
