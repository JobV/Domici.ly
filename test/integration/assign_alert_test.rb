require 'test_helper'

## Assiging an alert
#
# 1. You should be able to assign an alert to anyone
# 2. Only moderators and maintenance should be able to assign

class AssignAlertTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)

    # Random user
    @home_owner = create(:user, hoa: @hoa, first_name: 'Job')

    # Maintenance person
    @maintenance = create(:user, hoa: @hoa, first_name: 'Piet')
    @maintenance.add_role :maintenance, @hoa

    # Board member
    @moderator = create(:user, hoa: @hoa, first_name: 'Steve')
    @moderator.add_role :moderator, @hoa
  end

  test 'home_owner can not assign an alert' do
    sign_in @home_owner
    click_on 'alerts'
    click_on 'new-alert'
    page_should_not_contain 'Toewijzen aan'
  end

  test 'maintenance can assign an alert' do
    sign_in @maintenance
    click_on 'alerts'
    click_on 'new-alert'
    page_should_contain 'Toewijzen aan'
  end

  test 'moderator can assign an alert' do
    sign_in @moderator
    click_on 'alerts'
    click_on 'new-alert'
    page_should_contain 'Toewijzen aan'
  end

  test 'assigned user gets an email on new alert' do
    sign_in @moderator
    click_on 'alerts'
    click_on 'new-alert'
    fill_in 'alert_title', with: ExampleAlert.title
    fill_in 'alert_body', with: ExampleAlert.body
    select 'Piet'
    fill_in 'alert_tag_list', with: ExampleAlert.tag

    Sidekiq::Testing.inline! do
      assert_difference('Alert.count') do
        click_on 'Publiceer melding'
      end

      alert = Alert.last
      email = ActionMailer::Base.deliveries.last
      assert_equal alert.assignee.email, email.to[0]
    end

    assert_equal Alert.last.collaborations.length, 2, 'Should have two collaborations: one for current and other for assignee'
  end

  test 'assigned user gets an email on existing alert' do
    sign_in @moderator
    new_alert = create(:alert, hoa: @hoa, user: @moderator, title: 'Lalalala alert')
    click_on 'Meldingen'
    click_on new_alert.title

    click_on 'Melding aanpassen'
    select 'Piet Doe', from: 'alert_assignee_id'

    Sidekiq::Testing.inline! do
      click_on 'Publiceer melding'

      assert Alert.last.assignee, 'Alert should have an assignee'

      email = ActionMailer::Base.deliveries.last
      assert_equal Alert.last.assignee.email, email.to[0]
    end
  end

  test 'maintenance is able to change the status of an assigned alert' do
    moderator_creates_alert(@maintenance)

    sign_in @maintenance
    click_on 'alerts'
    click_on ExampleAlert.title
    click_on 'In behandeling'
    assert Alert.last.in_progress?
  end

  test 'maintence is not able to change the status of another alert' do
    moderator_creates_alert(@home_owner)

    sign_in @maintenance
    click_on 'alerts'
    page_should_not_contain ExampleAlert.title
  end

  def moderator_creates_alert(assignee)
    sign_in @moderator
    click_on 'alerts'
    click_on 'new-alert'
    fill_in 'alert_title', with: ExampleAlert.title
    fill_in 'alert_body', with: ExampleAlert.body
    select assignee.full_name
    fill_in 'alert_tag_list', with: ExampleAlert.tag

    assert_difference('Alert.count') do
      click_on 'Publiceer melding'
    end
    click_on 'sign_out'
  end
end
