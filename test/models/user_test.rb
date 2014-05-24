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

    user.address = ''
    assert ! user.got_started?, 'user does not have an address and should not be started'
    user.address = 'Badhuisweg'
  end

  test '#address complete?' do
    user = build(:user)
    assert user.address_complete?, 'address should be complete'

    user.address = ''
    assert ! user.address_complete?, 'address should not be complete'

    user = build(:user, house_number: '')
    assert ! user.address_complete?, 'address should not be complete'

    user = build(:user, postal_code: '')
    assert ! user.address_complete?, 'address should not be complete'
  end

  test '#profile_complete_percentage?' do
    user = create(:user)
    create(:alert, user: user)

    assert_equal 100, user.profile_complete_percentage

    user.address = ''
    assert_equal (6.0 / 7.0) * 100, user.profile_complete_percentage

    user.phone_number = ''
    assert_equal (5.0 / 7.0) * 100, user.profile_complete_percentage

  end
end
