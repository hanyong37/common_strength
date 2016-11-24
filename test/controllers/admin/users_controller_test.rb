require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_admin)
    @new_user = User.create(full_name: 'temp_user',
                                    password_digest: BCrypt::Password.create('1234'),
                                    token: SecureRandom.base58(24)
                                    )
  end

  test "should get index" do
    get admin_users_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post(admin_users_url,
           params: { user: { full_name: 'temp_user_2',
                             password: '1234',
                             token: SecureRandom.base58(24)}
      },
                              headers: auth_header,
                              as: :json)
    end

    assert_response 201
  end

  test "should show user" do
    get admin_user_url(@user),  headers: auth_header,as: :json
    assert_response :success
  end

  test "should update user" do
      patch admin_user_url(@user), params: { user: { password:'2345'} }, headers: auth_header, as: :json

    assert_response 200
  end

  test "should destroy " do
    assert_difference('User.count', -1) do
      delete admin_user_url(@new_user), headers: auth_header , as: :json
    end

    assert_response 204
  end

  test "should not destroy the last user" do
    @new_user.destroy
    assert_difference('User.count', 0) do
      delete admin_user_url(@user), headers: auth_header , as: :json
    end
    assert_response 422

  end

end
