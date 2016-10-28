require 'test_helper'

class Weixin::MySchedulesControllerTest < ActionDispatch::IntegrationTest

  test 'weixin myschedule index' do
    get weixin_my_schedules_path, headers: weixin_auth_header
    assert_response :success
  end

  test 'weixin myschedule show' do
    get '/weixin/my_schedules/2016-10-20', headers: weixin_auth_header
    assert_response :success
    assert jresponse['data'].count == 1
  end

end
