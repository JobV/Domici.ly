require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test '#name' do
    assert_equal @user.name, 'John'

    @user.first_name = nil
    assert_equal @user.name, 'Doe'

    @user.last_name = nil
    assert_equal @user.name, 'john@doe.com'
  end
end
