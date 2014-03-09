require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test '#name' do
    assert_equal 'John', @user.name

    @user.first_name = nil
    assert_equal 'Doe', @user.name

    @user.last_name = nil
    assert_equal 'test@new.com', @user.name
  end
end
