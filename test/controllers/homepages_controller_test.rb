require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in create(:user)
    @homepage = create(:homepage)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:homepages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create homepage" do
    assert_difference('Homepage.count') do
      post :create, homepage: {  }
    end

    assert_redirected_to homepage_path(assigns(:homepage))
  end

  test "should show homepage" do
    @request.host = "jaxons.localhost"
    get :show, id: @homepage
    assert_redirected_to new_user_session_path
  end

  # test "should get edit" do
  #   @request.host = "jaxons.localhost"
  #   get :edit, id: @homepage
  #   assert_response :success
  # end

  # test "should update homepage" do
  #   @request.host = "jaxons.localhost"
  #   patch :update, id: @homepage, homepage: {  }
  #   assert_redirected_to homepage_path(assigns(:homepage))
  # end

  test "should destroy homepage" do
    assert_difference('Homepage.count', -1) do
      delete :destroy, id: @homepage
    end

    assert_redirected_to homepages_path
  end
end
