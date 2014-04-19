require 'test_helper'

class AssignmentMailerTest < ActionMailer::TestCase
  test "assigned_to_alert" do
    assignee = create(:user)
    assigner = create(:user)
    alert = create(:alert)

    email = AssignmentMailer.assigned_to_alert(assigner, assignee, alert).deliver
    assert_not ActionMailer::Base.deliveries.empty?, 
      'Email should not be empty'

    # Test the body of the sent email contains what we expect it to
    assert_equal ['info@domici.ly'], email.from
    assert_equal [assignee.email], email.to
    assert_equal "Toegewezen: #{alert.title}", email.subject
  end
end
