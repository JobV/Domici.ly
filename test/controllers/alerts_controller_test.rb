require 'test_helper'

class AlertsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = create(:user)
    sign_in @user
    @alert = create(:alert, user: @user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alert" do
    assert_difference('Alert.count') do
      post :create, alert: { body: @alert.body, severity: @alert.severity, title: @alert.title }
    end

    assert_redirected_to alert_path(Alert.last)
  end

  test "should show alert" do
    get :show, id: @alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alert
    assert_response :success
  end

  test "should update alert" do
    patch :update, id: @alert, alert: { body: @alert.body, severity: @alert.severity, title: @alert.title }
    assert_redirected_to alert_path(assigns(:alert))
  end

  test "should destroy alert" do
    assert_difference('Alert.count', -1) do
      delete :destroy, id: @alert
    end

    assert_redirected_to dashboard_index_path
  end
end
