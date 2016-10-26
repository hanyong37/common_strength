require 'test_helper'

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should forbidden for unauthorized request' do
    get '/admin/users'
    assert_response :forbidden
  end

  test 'login success' do
    #get token and login
    post admin_session_path, params:{
      user:
      {
        full_name: 'admin',
        password: '1234'
      }
    }
    assert_response :success, 'response should be success with right username and password'
    assert_not_nil @token = jresponse['data']['attributes']['token'], 'json response should include a token'
    assert_equal 'admin', jresponse['data']['attributes']['full-name'], 'json response should have right user name'

    #access resource with token
    get '/admin/users', headers: {'x-api-key' => @token}
    assert_response :success, 'should sucesscc with right token.'

    #loginout , change token
    delete '/admin/session', headers:{'x-api-key' =>  @token}
    assert_response :no_content, 'session delete should works'
    get '/admin/users', headers: {'x-api-key' =>  @token}
    assert_response :forbidden, 'token should have changed after logout.'
  end

  test 'login failed with wrong u&p' do
    post admin_session_path, params:{user:{full_name:'foo',password:'foo'}}
    assert_response :unauthorized
  end

end
