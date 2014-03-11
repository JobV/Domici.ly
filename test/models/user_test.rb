require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test '#name' do
    assert_equal @user.first_name, @user.name

    @user.first_name = nil
    assert_equal @user.last_name, @user.name

    @user.last_name = nil
    assert_equal @user.email, @user.name
  end
end
