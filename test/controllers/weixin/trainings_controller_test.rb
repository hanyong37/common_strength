require 'test_helper'

class Weixin::TrainingsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'get single training'do
    get '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['booking-status'] == 'booked'
    assert jresponse['data']['attributes']['cancelable'] == false
  end

  test '409 for incancellable training' do
    delete '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :conflict
  end

  test '404 for incorrect  training id' do
    delete '/weixin/trainings/11234', headers: weixin_auth_header
    assert_response :not_found
  end

  test '204 for cancellable  training id' do
    t = trainings(:one)
    t.schedule.update(start_time: DateTime.now.advance(days: 2))

    #修改前
    get '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert jresponse['data']['attributes']['cancelable'] == true

    #修改后
    delete '/weixin/trainings/'+trainings(:one).id.to_s, headers: weixin_auth_header
    assert_response :success
    assert_nil  Training.find_by_id(trainings(:one).id)
  end

end
