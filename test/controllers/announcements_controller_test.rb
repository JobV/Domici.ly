require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in create(:user)
    @announcement = create(:announcement)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create announcement" do
    assert_difference('Announcement.count') do
      post :create, announcement: { body: @announcement.body, hoa_id: @announcement.hoa_id, target_group: @announcement.target_group, title: @announcement.title, user_id: @announcement.user_id }
    end

    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should show announcement" do
    get :show, id: @announcement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @announcement
    assert_response :success
  end

  test "should update announcement" do
    patch :update, id: @announcement, announcement: { body: @announcement.body, hoa_id: @announcement.hoa_id, target_group: @announcement.target_group, title: @announcement.title, user_id: @announcement.user_id }
    assert_redirected_to announcement_path(assigns(:announcement))
  end

  test "should destroy announcement" do
    assert_difference('Announcement.count', -1) do
      delete :destroy, id: @announcement
    end

    assert_redirected_to announcements_path
  end
end
