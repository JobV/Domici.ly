require 'test_helper'

## Help page
#
# 1. Anyone can quickly send an email naar support

class HelpPageTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @home_owner = create(:user, hoa: @hoa, first_name: 'Job')
  end

  test 'Anyone can send an email to support by going to help' do
    sign_in @home_owner
    click_on 'Help'

    fill_in 'Beschrijving van jouw probleem of suggestie', with: 'Woo woo'
    click_on 'Verstuur naar Support'

    Sidekiq::Testing.inline! do
      email = ActionMailer::Base.deliveries.last
      assert_equal @home_owner.email, email.from[0]
      assert_equal 'support@jaxons.nl', email.to[0]      
    end
  end

end
