require 'test_helper'

class Admin::UnpublishAllControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    Schedule.update_all(is_published: true)
    @store_one_id = stores(:one).id.to_s
  end

  test 'unpublish_all success' do

    post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-11-22/unpublish_all',  headers: auth_header
    assert_response :not_found

    post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-10*22/unpublish_all',  headers: auth_header
    assert_response :unprocessable_entity

    post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-10-20/unpublish_all',  headers: auth_header
    assert_response :conflict

    assert_difference('Schedule.where(is_published: true).count', -1) do
      post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-10-10/unpublish_all',  headers: auth_header
    end
    assert_response :success
  end

end
