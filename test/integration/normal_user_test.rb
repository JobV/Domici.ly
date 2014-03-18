require 'test_helper'

class NormalUserTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa)
    create(:alert)
    sign_in @user
  end

  test 'page should not contain admin' do
    page_should_not_contain 'Admin'
  end

  test 'page should not contain hoa admin' do
    page_should_not_contain 'Beheer'
  end
end