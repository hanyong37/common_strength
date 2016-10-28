require 'test_helper'

class Admin::PublishesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @store_one_id = stores(:one).id.to_s

  end

  test 'publish_all success' do

    post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-11-22/publish_all',  headers: auth_header
    assert_response :not_found

    post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-10*22/publish_all',  headers: auth_header
    assert_response :unprocessable_entity

    assert_difference('Schedule.where(is_published: true).count', 2) do
      post '/admin/stores/'+@store_one_id+'/schedules_by_week/2016-10-20/publish_all',  headers: auth_header
    end
    assert_response :success
  end

end
