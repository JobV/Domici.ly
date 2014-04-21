require 'test_helper'

class SupportMailerTest < ActionMailer::TestCase
  test 'support_ticket' do
    sender = create(:user)
    text   = 'Hallo blablabalbalab er gaat iets heel erg fout'

    email = SupportMailer.support_ticket(sender,text).deliver
    assert_not ActionMailer::Base.deliveries.empty?, 
      'Email should not be empty'

    assert_equal [sender.email], email.from
    assert_equal ['support@jaxons.nl'], email.to
  end
end
