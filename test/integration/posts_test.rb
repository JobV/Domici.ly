require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa)
    create(:alert)
    sign_in @user
  end

  test 'user can create post' do
    fill_in 'post_title', with: 'This is a test'
  end
end
