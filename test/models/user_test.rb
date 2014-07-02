# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  hoa_id                 :integer
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  address                :string(255)
#  house_number           :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#  city                   :string(255)
#

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
