require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
    @new_course = @course.dup
    @new_course.save
  end

  test "should get index" do
    get admin_courses_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post admin_courses_url, headers: auth_header, params: { course: {name: '测试课程', type_id: course_types(:one).id, store_id: stores(:one).id }}
    end

    assert_response :created
  end

  test "should show course" do
    get admin_course_url(@course), headers: auth_header, as: :json
    assert_response :success
  end

  test "should update course" do
    patch admin_course_url(@course), headers: auth_header, params: { course: {name: 'changed name'  } }, as: :json
    assert_response 200
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete admin_course_url(@new_course), headers: auth_header, as: :json
    end

    assert_response 204
  end
end
