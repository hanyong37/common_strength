require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
    @new_store = Store.create(name: 'to be deleted')
  end

  test "should get index" do
    get admin_stores_url,  headers: auth_header, as: :json
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post admin_stores_url, params: { store: { address: @store.address, name: 'new sotre added in testing', telphone: @store.telphone } }, headers: auth_header, as: :json
    end


    assert_response 201
  end

  test "should show store" do
    get admin_store_url(@store),  headers: auth_header, as: :json
    assert_response :success
  end

  test "should update store" do
    patch admin_store_url(@store), params: { store: { address: @store.address, name: @store.name, telphone: @store.telphone } }, headers: auth_header, as: :json
    assert_response 200
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete admin_store_url(@new_store),  headers: auth_header, as: :json
    end

    assert_response 204
  end
end
