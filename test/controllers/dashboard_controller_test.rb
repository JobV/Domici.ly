require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test 'should show dashboard' do
    get :index
    assert_response :success
  end
end
