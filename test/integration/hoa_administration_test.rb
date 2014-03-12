require 'test_helper'

class HoaAdministrationTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member, hoa: @hoa)
    create(:alert)
    sign_in @user
  end

  test 'can click link as board_member' do

  end
end
