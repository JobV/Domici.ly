require 'test_helper'

# A board member should be able to CRUD everything

class BoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.lint
    @hoa = create(:hoa)
    create(:user, hoa: @hoa, first_name: 'Job')
    @user = create(:board_member, hoa: @hoa)
    @user.add_role :moderator, @hoa
    # @alert = create(:alert, hoa: @hoa, user: @user)
  end

  test 'board member log in' do
    sign_in @user
    page_should_not_contain 'Admin'
  end

  test 'add alert' do
    sign_in @user

    within('#feed-head') do
      click_on 'Melding'
    end

    fill_in 'alert_title', with: ExampleAlert.title
    fill_in 'alert_body', with: ExampleAlert.body
    select ExampleAlert.assignee
    fill_in 'alert_tag_list', with: ExampleAlert.tag
    click_on 'Publiceer melding'

    click_on 'Meldingen'
    within('#tab1') do
      click_on ExampleAlert.title
    end
    
    page_should_contain ExampleAlert.title
    page_should_contain ExampleAlert.body
    page_should_contain ExampleAlert.tag

    assert_equal Alert.last.collaborations.length, 2, 'On create of Alert, a collaboration should be made including the current user and the assignee.'

    # page_should_not_contain @alert.body
  end
end
