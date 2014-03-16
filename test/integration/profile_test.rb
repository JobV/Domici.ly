require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa, first_name: 'Job', last_name: 'van der Voort', email: 'job@jaxons.nl')
    create(:alert, user: @user, hoa: @hoa, title: 'Kraan lekt')
  end

  def go_to_profile
    sign_in @user
    click_on @user.name
  end

  test 'profile shows all basic information' do
    go_to_profile

    page_should_contain 'Job van der Voort'
    page_should_contain 'VvE de Lotus'
    page_should_contain 'Mijn meldingen'
    page_should_contain 'Kraan lekt'
  end
  
  test 'edit personal information' do
    go_to_profile

    click_on 'Pas mijn gegevens aan'
  end  
end
