require 'test_helper'

# A board member should be able to CRUD everything

class BoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    create(:user, hoa: @hoa, first_name: 'Job')
    @user = create(:board_member, hoa: @hoa)
    @user.add_role :moderator, @hoa
    @alert = create(:alert)
  end

  test 'board member log in' do
    sign_in @user
    page_should_not_contain 'Admin'
  end

  test 'add alert' do
    sign_in @user

    click_on 'Nieuwe Melding'

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

    page_should_not_contain @alert.body
  end

  # test 'change state of alert' do
  #   new_alert = create :alert, hoa: @hoa, user: @user
  #   sign_in @user
  #   visit alert_path(new_alert)
  #   assert_equal new_alert.progress, 'new'
  #   click_on 'In behandeling'
  #   assert_equal 'in progress', new_alert.progress
  #   click_on 'Klaar'
  #   assert_equal new_alert.progress, 'completed'
  # end
end
