require 'test_helper'

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training = trainings(:one)
  end

  test "should get index" do
    get trainings_url, as: :json
    assert_response :success
  end

  test "should create training" do
    assert_difference('Training.count') do
      post trainings_url, params: { training: { schedule_id: @training.schedule_id, status: @training.status, user_id: @training.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show training" do
    get training_url(@training), as: :json
    assert_response :success
  end

  test "should update training" do
    patch training_url(@training), params: { training: { schedule_id: @training.schedule_id, status: @training.status, user_id: @training.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy training" do
    assert_difference('Training.count', -1) do
      delete training_url(@training), as: :json
    end

    assert_response 204
  end
end
