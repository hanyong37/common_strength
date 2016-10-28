require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    cst = customers(:luochao)
    put admin_customer_path(cst.id), params: {customer:{is_locked: true}},  headers: auth_header
    cst = Customer.find cst.id
    @operation = cst.operations.first
  end

  test "should get index" do
    get admin_operations_url, headers: auth_header , as: :json
    assert_response :success

    get admin_customer_operations_path(customers(:luochao)), headers: auth_header , as: :json
    assert_response :success

    get admin_user_operations_path(users(:user_admin)), headers: auth_header , as: :json
    assert_response :success
  end


  test "should show operation" do
    get admin_operation_url(@operation),  headers: auth_header ,as: :json
    assert_response :success
  end

end
