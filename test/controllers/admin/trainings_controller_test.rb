require 'test_helper'

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training = trainings(:one)
  end

  test "should get index" do
    get admin_trainings_url, headers: auth_header , as: :json
    assert_response :success
  end

  test "should create training" do
    assert_difference('Training.count') do
      post admin_trainings_url, params: { training: { customer_id: customers(:dapeng).id, schedule_id: schedules(:one).id, booking_status: 'booked' , training_status: 'normal'} }, headers: auth_header , as: :json
    end

    assert_response 201
  end

  test "should show training" do
    get admin_training_url(@training), headers: auth_header , as: :json
    assert_response :success
  end

  test "should update training" do
    patch admin_training_url(@training), params: { training: { booking_status: 'waiting'} }, headers: auth_header , as: :json
    assert_response 200
  end

  test "should destroy training" do
    assert_difference('Training.count', -1) do
      delete admin_training_url(@training), headers: auth_header , as: :json
    end

    assert_response 204
  end
end
