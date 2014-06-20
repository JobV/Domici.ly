require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test 'sign up' do
    visit root_path
    click_on 'Registreer'

    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'jobiscool'
    fill_in 'user_password_confirmation', with: 'jobiscool'
    check 'accept-me'
    assert_difference('User.count') do
      click_on 'Schrijf in'
    end

    fill_in 'hoa_name', with: 'testhoa'
    fill_in 'hoa_subdomain_name', with: 'testhoa'
    fill_in 'hoa_address', with: 'somewhere over the rainbow'
    fill_in 'hoa_postal_code', with: '12354ba'
    fill_in 'hoa_city', with: 'zaaidam'
    assert_difference('Hoa.count') do
      click_on 'Maak mijn vereniging aan'
    end



  end
end
