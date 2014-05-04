require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  require 'public_activity/testing'
  PublicActivity.enabled = false

  setup do
    @user = create(:user_without_hoa)
    sign_in @user
  end

  test "should get welcome" do
    get :welcome
    assert_response :success
  end
end
