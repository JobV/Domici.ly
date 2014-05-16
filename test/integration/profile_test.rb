require 'test_helper'

class ProfileTest < ActionDispatch::IntegrationTest
  def setup
    @hoa = create(:hoa)
    @user = create(:user, hoa: @hoa, first_name: 'Job', last_name: 'van der Voort', email: 'job@jaxons.nl')
    create(:alert, user: @user, hoa: @hoa, title: 'Kraan lekt')
  end
end
