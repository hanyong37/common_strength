require 'test_helper'

class Admin::SchedulesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @schedule = schedules(:one)
    @new_schedule = @schedule.dup
    @new_schedule.save
  end

  test "should get index" do
    get admin_schedules_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post admin_schedules_url, headers: auth_header, params: { schedule: {course_id: courses(:one).id, store_id: stores(:one).id, start_time: DateTime.now(), end_time: DateTime.now(), capacity: 10, is_published: false}}
    end

    assert_response :created
  end

  test "should show schedule" do
    get admin_schedule_url(@schedule), headers: auth_header, as: :json
    assert_response :success
  end

  test "should update schedule" do
    patch admin_schedule_url(@schedule), headers: auth_header, params: { schedule: {name: 'changed name'  } }, as: :json
    assert_response 200
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete admin_schedule_url(@new_schedule), headers: auth_header, as: :json
    end

    assert_response 204
  end
end
