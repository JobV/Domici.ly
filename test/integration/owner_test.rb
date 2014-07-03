require 'test_helper'

class OwnerTest < ActionDispatch::IntegrationTest
  def setup
    default_test_setup
    @alert_by_mod         = user_creates_alert(@moderator)
    @alert_by_home_owner  = user_creates_alert(@home_owner)
    @alert_by_maintenance = user_creates_alert(@maintenance)
  end

  test 'normal user can not see alerts not related to him' do
    sign_in @home_owner
    click_on @hoa.name
    page_should_contain @alert_by_home_owner.title
    page_should_not_contain @alert_by_mod.title
    page_should_not_contain @alert_by_maintenance.title

    click_on 'Meldingen'

    page_should_contain @alert_by_home_owner.title
    page_should_not_contain @alert_by_mod.title
    page_should_not_contain @alert_by_maintenance.title    
  end

  test 'maintenance user can not see alerts not related to him' do
    sign_in @maintenance
    click_on @hoa.name
    page_should_not_contain @alert_by_home_owner.title
    page_should_not_contain @alert_by_mod.title
    page_should_contain @alert_by_maintenance.title

    click_on 'Meldingen'

    page_should_not_contain @alert_by_home_owner.title
    page_should_not_contain @alert_by_mod.title
    page_should_contain @alert_by_maintenance.title    
  end

  test 'moderator user can see all alerts related to him' do
    sign_in @moderator
    click_on @hoa.name
    page_should_contain @alert_by_home_owner.title
    page_should_contain @alert_by_mod.title
    page_should_contain @alert_by_maintenance.title

    click_on 'Meldingen'

    page_should_contain @alert_by_home_owner.title
    page_should_contain @alert_by_mod.title
    page_should_contain @alert_by_maintenance.title    
  end

  def user_creates_alert(user)
    sign_in user
    click_on 'alerts'
    click_on 'new-alert'
    fill_in 'alert_title',    with: "testtitle#{Random.rand(2000)}"
    fill_in 'alert_body',     with: "body#{Random.rand(2000)}"
    fill_in 'alert_tag_list', with: ExampleAlert.tag

    assert_difference('Alert.count') do
      click_on 'Publiceer melding'
    end
    click_on 'sign_out'
    return Alert.last
  end
end
