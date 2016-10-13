require 'test_helper'

class CourseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_type = course_types(:one)
  end

  test "should get index" do
    get course_types_url, as: :json
    assert_response :success
  end

  test "should create course_type" do
    assert_difference('CourseType.count') do
      post course_types_url, params: { course_type: { description: @course_type.description, name: @course_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show course_type" do
    get course_type_url(@course_type), as: :json
    assert_response :success
  end

  test "should update course_type" do
    patch course_type_url(@course_type), params: { course_type: { description: @course_type.description, name: @course_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy course_type" do
    assert_difference('CourseType.count', -1) do
      delete course_type_url(@course_type), as: :json
    end

    assert_response 204
  end
end
