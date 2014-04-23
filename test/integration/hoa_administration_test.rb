require 'test_helper'

class HoaAdministrationTest < ActionDispatch::IntegrationTest
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

  test 'boardmember can remove a user from the hoa' do
    sign_in @moderator
    click_on @hoa.name
    page_should_contain @home_owner.full_name
    click_on "remove-#{@home_owner.id}"
    assert ! User.find(@home_owner.id).hoa, 'User should be removed from HOA, but is not.'
  end
end
