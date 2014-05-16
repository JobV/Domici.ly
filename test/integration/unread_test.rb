require 'test_helper'

class UnreadTest < ActionDispatch::IntegrationTest
  def setup
    @hoa        = create(:hoa)
    @moderator  = create(:user, hoa: @hoa, first_name: 'Job')
    @moderator.add_role :moderator, @hoa
    @alert1     = create(:alert, hoa: @hoa)
    @alert2     = create(:alert, hoa: @hoa)
  end

  # test 'moderator sees amount of unread alerts' do
  #   sign_in @moderator
  #   within('#unread-alerts') do
  #     page_should_contain '2'      
  #   end
  # end
end
