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
    post admin_sessions_path, params:{
      user:
      {
       full_name: 'admin',
       password: '1234'
      }
    }
    assert_response :success, 'response should be success with right username and password'
    assert_not_nil @token = jresponse['data']['attributes']['token'], 'json response should include a token'
    assert_equal 'admin', jresponse['data']['attributes']['full-name'], 'json response should have right user name'
    #assert_equal 'admin', current_user.full_name, 'controller should have a current user created '
  end

  test 'login failed with wrong u&p' do
    post admin_sessions_path, params:{user:{full_name:'foo',password:'foo'}}
    assert_response :unauthorized
  end

  test 'login out should change token in db' do
    user = User.find_by(full_name: 'admin')
    old_token = user.token
    delete admin_session_path(user.id), auth_header

    assert_response :no_content
    assert_nil User.find_by(token: old_token)
  end

end
