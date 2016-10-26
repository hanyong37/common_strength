require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:booking_limit_days)
  end

  test "should get index" do
    get admin_settings_url,  headers: auth_header ,as: :json
    assert_response :success
  end

  test "should show setting" do
    get admin_setting_url('booking_limit_days'),  headers: auth_header ,as: :json
    assert_response :success
  end

  test "should update setting" do
    patch admin_setting_url('booking_limit_days'), params: { setting: { value: 10  } },  headers: auth_header ,as: :json
    assert_response 200
  end
end
