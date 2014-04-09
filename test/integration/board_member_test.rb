require 'test_helper'

class BoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member, hoa: @hoa)
    @user.add_role :moderator, @hoa
    create(:alert)
  end

  test 'sign in' do
    sign_in @user
  end

  test 'board member log in' do
    sign_in @user

    page_should_contain @user.first_name
    page_should_contain @hoa.name

    page_should_not_contain 'Admin'
  end

  ## Alerts

  test 'add alert' do
    sign_in @user

    click_on @hoa.name
    click_on 'Nieuwe Melding'

    fill_in 'alert_title', with: 'Kapotte tree in trappenhuis'
    fill_in 'alert_body', with: 'In het trappenhuis op de derde verdieping is een tree kapot. Heel erg kapot. Pas op voor de tree.'
    click_on 'Publiceer melding'

    click_on @hoa.name

    page_should_contain 'Kapotte tree in trappenhuis'
    page_should_contain 'In het trappenhuis op de derde verdieping is een tree kapot. Heel erg kapot. Pas op voor de tree.'

    page_should_not_contain 'Gat in muur, ergens.'
  end

  test 'view alert' do
    sign_in @user
    create :alert, user_id: @user.id, hoa: @hoa
    visit root_path
    click_on @hoa.name

    page_should_contain 'Gat in muur'
    click_on 'Gat in muur'

    page_should_contain 'Er is een gat ergens'
    page_should_contain 'Geplaatst door John'
    page_should_contain 'Aanpassen'
    page_should_contain 'Terug'
  end

  test 'change state of alert' do
    sign_in @user
    create :alert, hoa: @hoa
    click_on @user.hoa_name
    
    page_should_contain 'Nieuw'
    click_on 'Gat in muur, ergens.'

    page_should_contain 'Nieuw'

    page_should_contain 'Sluit melding'

    visit root_path
    
  end

  ## Add member

  def add_member(email, role)
    sign_in @user
    click_on @hoa.name
    click_on 'new-member'
    fill_in :user_email, with: email
    choose role
    click_on 'Verstuur uitnodiging'
  end

  test 'add member' do
    assert_difference('User.count') do
      add_member 'user@normal.com', 'role_user'
    end

    assert ! User.last.has_role?(:moderator, @hoa)

    email = ActionMailer::Base.deliveries.last
    assert email
    assert_equal ['user@normal.com'], email.to
  end

  test 'add board member' do
    assert_difference('User.count') do
      add_member 'boardie@member.com', 'role_moderator'
    end
    assert User.last.has_role?(:moderator, @hoa)
  end
end
