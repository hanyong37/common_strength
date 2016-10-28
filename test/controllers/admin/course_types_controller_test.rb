require 'test_helper'

class CourseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_type = course_types(:one)
    @new_course_type = @course_type.dup
    @new_course_type.name = 'another course name'
    @new_course_type.save
  end

  test "should get index" do
    get admin_course_types_url, headers: auth_header , as: :json
    assert_response :success
  end

  test "should get show" do
    get admin_course_type_path(@course_type), headers: auth_header , as: :json
    assert_response :success
  end

  test "should create course_type" do
    assert_difference('CourseType.count') do
      post admin_course_types_url, params: { course_type: { description: @course_type.description, name: 'no dup name' } },headers: auth_header ,   as: :json
    end

    assert_response 201
  end


  test "should update course_type" do
    patch admin_course_type_url(@course_type), params: { course_type: { description: @course_type.description, name: 'new name' } },headers: auth_header , as: :json
    assert_response 200
  end

  test "should destroy course_type" do
    assert_difference('CourseType.count', -1) do
      delete admin_course_type_url(@new_course_type),headers: auth_header , as: :json
    end

    assert_response 204
  end
end
