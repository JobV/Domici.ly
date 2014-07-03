require 'test_helper'

class OwnerTest < ActionDispatch::IntegrationTest
  def setup
    default_test_setup
    @alert = create(:alert, hoa: @hoa, user: @moderator)
  end

  test 'owner can not see alerts not related to him' do
    sign_in @home_owner

    page_should_not_contain @alert.title
  end
end
