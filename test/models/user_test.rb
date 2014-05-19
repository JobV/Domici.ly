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

  test '#full_name' do
    assert_equal "#{@user.first_name} #{@user.last_name}", @user.full_name

    @user.first_name = nil
    assert_equal @user.last_name, @user.full_name

    @user.last_name = nil
    assert_equal @user.email, @user.full_name
  end

  test '#got_started?' do
    user = create(:user)

    user.first_name = ''
    user.last_name = ''
    assert ! user.got_started?, 'user is not started without names'

    user.first_name = 'Job'
    assert ! user.got_started?, 'user is not started without last_name'

    user.last_name = 'van der Voort'
    assert ! user.got_started?, 'user is not started without an alert'

    assert_equal 0, user.alerts.count, 'user should not have any alerts'
    create(:alert, user: user)
    assert_equal 1, user.alerts.count, 'user should have one alert'

    assert user.got_started?, 'user has names and an alert, should be started'

    user.first_name = ''

    assert ! user.got_started?, 'user does not have a first name anymore is not started'
  end
end
