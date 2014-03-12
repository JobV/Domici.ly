require 'test_helper'

class BoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member, hoa: @hoa)
    create(:alert)
  end

  test 'sign in' do
    sign_in @user
  end

  test 'board member log in' do
    sign_in @user

    page_should_contain 'John'
    page_should_contain 'VvE de Lotus'
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

  test 'view alert' do
    sign_in @user
    create :alert, user_id: @user.id
    visit root_path

    page_should_contain 'Gat in muur'
    click_on 'Gat in muur'

    page_should_contain 'Er is een gat ergens'
    page_should_contain 'Geplaatst door John'
    page_should_contain 'Aanpassen'
    page_should_contain 'Terug'
  end
end
