require 'test_helper'

class BillingTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.lint
    @hoa = create(:hoa)
    create(:user, hoa: @hoa, first_name: 'Job')
    @user = create(:board_member, hoa: @hoa)
    @user.add_role :moderator, @hoa
  end

  test 'billing page' do
    sign_in @user
    click_on 'Facturatie'
    page_should_contain 'abonnement'
  end
end
