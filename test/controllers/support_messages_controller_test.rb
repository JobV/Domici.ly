require 'test_helper'

class SupportMessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in create(:user)
    @support_message = create(:support_message)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:support_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create support_message" do
    assert_difference('SupportMessage.count') do
      post :create, support_message: { body: @support_message.body, hoa_id: @support_message.hoa_id, user_id: @support_message.user_id }
    end

    assert_redirected_to root_path
  end

  test "should show support_message" do
    get :show, id: @support_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @support_message
    assert_response :success
  end

  test "should update support_message" do
    patch :update, id: @support_message, support_message: { body: @support_message.body, hoa_id: @support_message.hoa_id, user_id: @support_message.user_id }
    assert_redirected_to support_message_path(assigns(:support_message))
  end

  test "should destroy support_message" do
    assert_difference('SupportMessage.count', -1) do
      delete :destroy, id: @support_message
    end

    assert_redirected_to support_messages_path
  end
end
