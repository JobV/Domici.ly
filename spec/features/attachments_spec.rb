require 'rails_helper'

feature :attachments, :type => :feature do
  given(:organisation) { create(:hoa) }
  given(:user)         { create(:user, hoa: organisation) }

  context 'on a new alert' do
    
  end
end
