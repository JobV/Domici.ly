require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa)
    create(:alert)
    sign_in @user
  end

  test 'user can create post' do
    page_should_contain 'Plaats een bericht'
  end
end
