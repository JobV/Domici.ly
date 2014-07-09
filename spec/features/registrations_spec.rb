require 'rails_helper'

feature "Registrations", :type => :feature do
  scenario 'User registration happy flow' do
    visit '/'
    click_on 'Registreer'
    fill_in 'user_email', with: 'j@b.com'
    fill_in 'user_password', with: 'jobiscool'
    fill_in 'user_password_confirmation', with: 'jobiscool'
    check 'accept-me'
    click_on 'Schrijf in'

    expect(page).to have_text 'Je bent ingeschreven.'

    fill_in 'hoa_name', with: 'jaxons'
    fill_in 'hoa_subdomain_name', with: 'jaxons'
    fill_in 'hoa_address', with: 'badhuisweg 1'
    fill_in 'hoa_postal_code', with: '1234ab'
    fill_in 'hoa_city', with: 'Zaandam'

    click_on 'Maak mijn vereniging aan'

    expect(page).to have_text 'Jouw vereniging is aangemaakt, gefeliciteerd!'
    expect(page).to have_text 'Geef je naam op in je profiel'
    expect(page).to have_text 'Doe een melding'
  end
end
