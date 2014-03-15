require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa, first_name: 'Job', last_name: 'van der Voort', email: 'job@jaxons.nl')
    create(:alert, user: @user, hoa: @hoa, title: 'Kraan lekt')
  end

  def go_to_profile
    sign_in @user
    click_on 'Mijn profiel'
  end

  test 'profile shows all basic information' do
    go_to_profile

    page_should_contain 'Job van der Voort'
    page_should_contain 'VvE de Lotus'
    page_should_contain 'Jouw meldingen'
    page_should_contain 'Kraan lekt'
  end
  
end
