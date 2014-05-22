require 'test_helper'

class MembersPageTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)

    # Random user
    @home_owner = create(:user, hoa: @hoa, first_name: 'Job')
  end

  test 'members page lists members' do
    sign_in @home_owner
    click_on 'members'
    save_and_open_page
    page_should_contain @home_owner.full_name
  end
end
