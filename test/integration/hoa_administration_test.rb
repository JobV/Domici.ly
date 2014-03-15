require 'test_helper'

class HoaAdministrationTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member, hoa: @hoa)
    5.times { create(:user, hoa: @hoa) }
    @alert = create(:alert, hoa: @hoa)
    sign_in @user
  end

  test 'can click link as board_member' do
    page_should_contain @alert.title

    click_on @hoa.name

    page_should_contain "6 leden"

  end
end
