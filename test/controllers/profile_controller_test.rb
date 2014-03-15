require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  def setup
    sign_in create(:user)
  end

  test 'should show profile' do
    get :index
    assert_response :success
  end
end
