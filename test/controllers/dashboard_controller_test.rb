require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  def setup
    sign_in create(:user)
  end
  test 'should show dashboard' do
    get :index
    assert_response :success
  end
end
