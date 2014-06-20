require 'test_helper'

class HoasControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @hoa = create(:hoa)
    @user = create(:admin, hoa: @hoa)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hoas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hoa" do
    assert_difference('Hoa.count') do
      post :create, hoa: { name: 'meeh', subdomain_name: 'test' }
    end

    assert_redirected_to organisation_url(subdomain: 'test')
  end

  test "should show hoa" do
    get :show, id: @hoa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hoa
    assert_response :success
  end

  test "should update hoa" do
    patch :update, id: @hoa, hoa: { name: @hoa.name }
    assert_redirected_to organisation_path
  end

  test "should destroy hoa" do
    assert_difference('Hoa.count', -1) do
      delete :destroy, id: @hoa
    end

    assert_redirected_to hoas_path
  end
end
