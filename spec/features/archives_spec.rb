require 'rails_helper'

feature "Archives", :type => :feature do
  given(:organisation) { create(:hoa) }
  given(:user)         { create(:user, hoa: organisation) }
  given(:alert)        { create(:alert, hoa: organisation, user: user)}


  scenario 'archiving a single alert' do
    sign_in user
    visit alert_path(alert)
    expect(page).to have_content 'Archiveer'
  end
end
