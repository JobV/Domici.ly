require 'test_helper'

class BoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member)
    create(:alert)
  end

  def sign_in(user)
    visit root_path

    fill_in 'user_email', with: 'board@member.com'
    fill_in 'user_password', with: 'jobiscool'

    click_on 'Log in'
  end

  test 'board member log in' do
    visit root_path

    fill_in 'user_email', with: 'board@member.com'
    fill_in 'user_password', with: 'jobiscool'

    click_on 'Log in'

    page_should_contain 'John'
    page_should_contain 'Nieuwe Melding'

    page_should_not_contain 'Admin'
  end

  test 'add alert' do
    sign_in @user

    click_on 'Nieuwe Melding'

    fill_in 'alert_title', with: 'Kapotte tree in trappenhuis'
    fill_in 'alert_body', with: 'In het trappenhuis op de derde verdieping is een tree kapot. Heel erg kapot. Pas op voor de tree.'
    click_on 'Publiceer melding'

    page_should_contain 'Kapotte tree in trappenhuis'
    page_should_contain 'In het trappenhuis op de derde verdieping is een tree kapot. Heel erg kapot. Pas op voor de tree.'
    page_should_contain 'Vandaag'

    page_should_not_contain 'Gat in muur, ergens.'
  end
end
