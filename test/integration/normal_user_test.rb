require 'test_helper'

class NormalUserTest < ActionDispatch::IntegrationTest
  def setup
    @user_without_hoa = create(:user_without_hoa)
  end

  test 'page should not contain admin' do
    sign_in @user_without_hoa
    page_should_not_contain 'Admin'
  end

  test 'user_without_hoa without hoa should be shown join/welcome page' do
    sign_in @user_without_hoa
    page_should_contain 'Maak je vereniging aan'
    page_should_contain 'Start met Domici.ly'
  end

  test 'user can create hoa in welcome screen' do
    sign_in @user_without_hoa
    # click_on 'Maak een vereniging aan'
  end

  test 'user can not create announcement' do
    sign_in build(:user)
    page_should_not_contain 'Mededeling'
  end
end
