require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:luochao)
    @new_customer = Customer.create(name: 'temp',
                                    mobile: 18912344321,
                                    weixin: 'foo_wx',
                                    store: stores(:one),
                                    membership_type: 'time_card',
                                    membership_duedate: Date.today.advance(days: 30))
  end

  test "should get index" do
    get admin_customers_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post(
        admin_customers_url,
        params: { customer: { mobile: 15812344321,
                              name: 'chenxi',
                              weixin: 'chenxi_wx',
                              store_id: stores(:one).id,
                              membership_duedate: Date.today.advance(days: 30),
                              membership_type: 'time_card' } },
                              headers: auth_header,
                              as: :json)
    end

    assert_response 201
    cx = Customer.find_by_name 'chenxi'
    assert_not_nil Operation.find_by_customer_id cx.id
  end

  test "should show customer" do
    get admin_customer_url(@customer),  headers: auth_header,as: :json
    assert_response :success
  end

  test "should update customer" do

    assert_difference('Operation.count', 1) do
      patch admin_customer_url(@customer), params: { customer: { mobile: @customer.mobile, name: @customer.name, weixin: @customer.weixin } }, headers: auth_header, as: :json
    end

    assert_response 200
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete admin_customer_url(@new_customer), headers: auth_header , as: :json
    end

    assert_response 204
  end
end
