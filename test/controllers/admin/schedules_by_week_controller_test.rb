require 'test_helper'

class Admin::WeekControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @store = stores(:one)
    @week_url =  '/admin/stores/'+@store.id.to_s+'/schedules_by_week'

  end

  test 'index schedules by week' do
    get @week_url+'/2016-10-20', headers: auth_header

    assert_response :success
    assert jresponse['data'].size == 2
  end

  test 'create scheudles by week' do

    post @week_url, headers: auth_header, params: {from_week: '2016-10-2', to_week: '2016-10-2'}
    assert_response :unprocessable_entity, '测试参数错误！'

    post @week_url, headers: auth_header, params: {from_week: '2016-1-10', to_week: '2016-10-28'}
    assert_response :not_found, '测试没有找到源数据！'

    post @week_url, headers: auth_header, params: {from_week: '2016-10-22', to_week: '2016-10-10'}
    assert_response :conflict, '测试冲突返回错误！'

    assert_difference('Schedule.count', 2) do
      post @week_url, headers: auth_header, params: {from_week: '2016-10-20', to_week: '2016-10-27'}
    end
    assert_response :success, '测试成功复制！'

  end

  test 'destroy by week' do
    #delete @week_url+'/this_and_anyweek', headers: auth_header
    #assert_response :unprocessable_entity

    delete @week_url+'/2016-10-1', headers: auth_header
    assert_response :not_found

    delete @week_url+'/2016-10-20', headers: auth_header
    assert_response :conflict

    delete @week_url+'/2016-10-10', headers: auth_header
    assert_response :success
  end
end
