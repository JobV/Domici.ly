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
    page_should_contain 'Welkom bij Domici.ly'
    page_should_contain 'Maak een vereniging aan'
  end
end
