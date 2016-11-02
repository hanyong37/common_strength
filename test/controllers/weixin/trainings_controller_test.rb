require 'test_helper'

class Weixin::TrainingsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'get single training'do
    get '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['booking-status'] == 'booked'
    assert jresponse['data']['attributes']['rebookable'] == false
    assert jresponse['data']['attributes']['cancelable'] == false
  end

  test '403 for ineditable training' do
    put '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :forbidden
  end

  test '404 for incorrect  training id' do
    put '/weixin/trainings/11234', headers: weixin_auth_header
    assert_response :not_found
  end

  test '200 for editable  training id' do
    t = trainings(:one)
    t.schedule.update(start_time: DateTime.now.advance(days: 2))

    #修改前
    get '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['rebookable'] == false
    assert jresponse['data']['attributes']['cancelable'] == true

    #修改后
    get '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    put '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['rebookable'] == true
    assert jresponse['data']['attributes']['cancelable'] == false
  end

end
