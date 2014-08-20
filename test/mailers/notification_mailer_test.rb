require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test 'comment on alert' do
    user    = create(:user)
    alert   = create(:alert, user: user)
    comment = alert.comments.create(user: user, comment: 'this is a comment')

    email = NotificationMailer.comment_on_alert(alert, comment, user.email).deliver
    assert_not ActionMailer::Base.deliveries.empty?,
      'Email should not be empty'

    assert_equal ['info@domici.ly'], email.from
    assert_equal [user.email], email.to
    assert_equal "[Domici.ly] Reactie op #{alert.title}", email.subject
  end

  test 'invitees' do
    hoa     = create(:hoa)
    user    = create(:user, hoa: hoa)
    5.times { create(:user, hoa: hoa) }
    event   = create(:event, user: user, hoa: hoa)
    group = 'everyone'

    email = NotificationMailer.invitees(event, group).deliver
    assert_not ActionMailer::Base.deliveries.empty?,
      'Email should not be empty'

    assert_equal ['info@domici.ly'], email.from
    assert_equal "[Domici.ly] Uitnodiging voor #{event.title}", email.subject
  end
end
