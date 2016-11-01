require 'test_helper'

class Weixin::SchedulesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test '200 for right schedule' do
    get '/weixin/schedules/'+schedules(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
  end

  test '404 for not found' do
    get '/weixin/schedules/200', headers: weixin_auth_header
    assert_response :not_found
  end

  test '403 for not authorized' do
    get '/weixin/schedules/'+schedules(:four).id.to_s, headers: weixin_auth_header
    assert_response 403
  end

end
