require 'test_helper'

class NormalUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test 'page should not contain admin' do
    page_should_not_contain 'Admin'
  end

  test 'user without hoa should be shown join/welcome page' do
    save_and_open_page
    page_should_contain 'Welkom bij Domici.ly'
    page_should_contain 'Maak een vereniging aan'
    page_should_contain 'Verzoek toegang tot een vereniging'
  end
end
