require 'test_helper'

class Weixin::MyInfoControllerTest < ActionDispatch::IntegrationTest
  test 'show my info for current customer' do
    get weixin_my_info_path, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['id'] == customers(:luochao).id.to_s
  end
end
