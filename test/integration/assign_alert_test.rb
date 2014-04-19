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
    click_on 'new-alert'
    page_should_not_contain 'Toewijzen aan'
  end

  test 'maintenance can assign an alert' do
    sign_in @maintenance
    click_on 'new-alert'
    page_should_contain 'Toewijzen aan'
  end

  test 'moderator can assign an alert' do
    sign_in @moderator
    click_on 'new-alert'
    page_should_contain 'Toewijzen aan'
  end
end
