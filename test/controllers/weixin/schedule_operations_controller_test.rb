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

  test "" do


  end
end
