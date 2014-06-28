require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  def setup
    default_test_setup
  end

  test 'moderator creates an alert with tag' do
    sign_in @moderator
    click_on 'alerts'
    click_on 'new-alert'
    fill_in 'alert_title', with: ExampleAlert.title
    fill_in 'alert_body', with: ExampleAlert.body
    fill_in 'alert_tag_list', with: ExampleAlert.tag

    assert_difference('Alert.count') do
      click_on 'Publiceer melding'
    end

    page_should_contain ExampleAlert.tag
  end
end
