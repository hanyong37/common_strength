require 'test_helper'

class Weixin::RegisterControllerTest < ActionDispatch::IntegrationTest

  setup do
  end

  test 'successfull registered' do
    post weixin_register_path , params:{openid: 'dapeng_openid',mobile: '13923455432'}
    assert_response :success
    assert customers(:dapeng).weixin == 'dapeng_openid'
  end

  test 'not found registered' do
    post weixin_register_path, params:{openid: 'dapeng_openid',mobile: '0000000000'}
    assert_response :not_found
  end

 # test 'conflict registered' do
 #   post weixin_register_path, params:{openid: 'dapeng_openid',mobile: '13912344321'}
 #   assert_response :conflict
 # end

  test 'params error registered' do
    post weixin_register_path, params:{mobile: '0000000000'}
    assert_response :bad_request
  end
end
