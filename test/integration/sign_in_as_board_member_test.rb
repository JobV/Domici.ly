require 'test_helper'

class SignInAsBoardMemberTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:board_member)
  end


end
