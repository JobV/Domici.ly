require 'test_helper'

class SignInAsBoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member)
  end

  test 'board member log in' do
    visit root_path

    fill_in 'user_email', with: 'board@member.com'
    fill_in 'user_password', with: 'jobiscool'

    click_on 'Log in'

    assert page.has_content? 'John'
    assert page.has_content? 'bestuurslid'

    refute page.has_content? 'Admin'
  end
end
