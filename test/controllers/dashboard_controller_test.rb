require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  def setup
    sign_in create(:user)
  end
  test 'should show dashboard' do
    get :index
    assert_response :success
  end
end
