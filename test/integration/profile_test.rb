require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  def setup
    hoa = create(:hoa)
    @user = create(:user, hoa: hoa)
  end

  test 'can edit profile' do
    sign_in @user
    click_on @user.first_name
    click_on 'Pas mijn gegevens aan'

    fill_in 'user_first_name', with: 'J'
    fill_in 'user_last_name', with: 'D'
    fill_in 'user_address', with: 'street'
    fill_in 'user_house_number', with: '57b'
    fill_in 'user_postal_code', with: '1234 abc'
    fill_in 'user_city', with: 'zaandam'
    fill_in 'user_phone_number', with: '1234567890'

    click_on 'Sla aanpassingen op'

    user = User.find(@user.id)
    assert_equal 'J', user.first_name
    assert_equal 'D', user.last_name
    assert_equal 'street', user.address
    assert_equal '57b', user.house_number
    assert_equal '1234 abc', user.postal_code
    assert_equal 'zaandam', user.city
    assert_equal '1234567890', user.phone_number

    page_should_contain 'J'
    page_should_contain 'D'
    page_should_contain 'street'
    page_should_contain '57b'
    page_should_contain '1234 abc'
    page_should_contain 'zaandam'
    page_should_contain '1234567890'
  end
end
