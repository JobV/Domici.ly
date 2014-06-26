require 'test_helper'

class EditUserTest < ActionDispatch::IntegrationTest
  def setup
    default_test_setup
  end

  test 'home_owner cant edit users' do
    sign_in @home_owner
    click_on 'members'
    page_should_not_contain "edit-user-#{@maintenance.id}"
  end

  test 'maintenance cant edit users' do
    sign_in @maintenance
    click_on 'members'
    page_should_not_contain "edit-user-#{@home_owner.id}"
  end

  test 'moderator can edit users' do
    sign_in @moderator
    click_on 'members'
    click_on "edit-user-#{@home_owner.id}"

    fill_in 'user_first_name', with: 'J'
    fill_in 'user_last_name', with: 'D'
    fill_in 'user_address', with: 'street'
    fill_in 'user_house_number', with: '57b'
    fill_in 'user_postal_code', with: '1234 abc'
    fill_in 'user_city', with: 'zaandam'
    fill_in 'user_phone_number', with: '1234567890'

    click_on 'Sla aanpassingen op'

    user = User.find(@home_owner.id)
    assert_equal 'J', user.first_name
    assert_equal 'D', user.last_name
    assert_equal 'street', user.address
    assert_equal '57b', user.house_number
    assert_equal '1234 abc', user.postal_code
    assert_equal 'zaandam', user.city
    assert_equal '1234567890', user.phone_number
  end
end
