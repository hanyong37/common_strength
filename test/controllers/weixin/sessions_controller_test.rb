require 'test_helper'

class Weixin::SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
  end

  test 'create sessions with right weixin openid' do
    post weixin_session_path, params:{openid: customers(:luochao).weixin }
    assert_response :success
  end

  test 'create sessions failed with wrong weixin openid' do
    post weixin_session_path, params:{openid: 'no_this_id' }
    assert_response :not_found
  end

end
