require 'test_helper'

class MembersPageTest < ActionDispatch::IntegrationTest
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

  test 'home_owner views members page' do
    sign_in @home_owner
    click_on 'members'
    page_should_contain @home_owner.full_name
    page_should_not_contain 'Aanpassen'
  end

  test 'maintenance views members page' do
    sign_in @maintenance
    click_on 'members'
    page_should_contain @maintenance.full_name
    page_should_not_contain 'Aanpassen'
  end

  test 'moderator can edit users' do
    sign_in @moderator
    click_on 'members'
    page_should_contain 'Aanpassen'

    click_on "change-to-moderator-#{@home_owner.id}"
    assert @home_owner.has_role?(:moderator, @hoa)

    click_on "change-to-maintenance-#{@home_owner.id}"
    assert @home_owner.has_role?(:maintenance, @hoa)

    click_on "change-to-owner-#{@home_owner.id}"
    assert ! @home_owner.has_role?(:moderator, @hoa)
    assert ! @home_owner.has_role?(:maintenance, @hoa)

    click_on "remove-#{@home_owner.id}"
    page_should_contain 'is verwijderd'
  end
end
