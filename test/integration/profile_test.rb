require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa)
    create(:alert)
  end

  
end
