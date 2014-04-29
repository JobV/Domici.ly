require 'test_helper'

class AnnouncementMailerTest < ActionMailer::TestCase
  test 'announcement to everyone' do
    hoa = create(:hoa)
    5.times { create(:user, hoa: hoa) }
    user = create(:user)
    announcement = create(:announcement, hoa: hoa, user: user)

    email = AnnouncementMailer.announcement_to_group(announcement).deliver
    assert_not ActionMailer::Base.deliveries.empty?, 
      'Email should not be empty'

    assert_equal [user.email], email.from
    assert_equal 5, email.bcc.length
    assert_equal announcement.title, email.subject
  end

  test 'announcement to moderators' do
    hoa = create(:hoa)
    5.times { create(:user, hoa: hoa) }
    5.times { u = create(:user, hoa: hoa); u.add_role(:moderator, hoa) }
    user = create(:user)
    announcement = create(:announcement_to_moderators, hoa: hoa, user: user)

    email = AnnouncementMailer.announcement_to_group(announcement).deliver
    assert_not ActionMailer::Base.deliveries.empty?, 
      'Email should not be empty'

    assert_equal [user.email], email.from
    assert_equal 5, email.bcc.length
    assert_equal announcement.title, email.subject
  end
end
  # test "assigned_to_alert" do
  #   assignee = create(:user)
  #   assigner = create(:user)
  #   alert = create(:alert)

  #   email = AssignmentMailer.assigned_to_alert(assigner, assignee, alert).deliver
  #   assert_not ActionMailer::Base.deliveries.empty?, 
  #     'Email should not be empty'

  #   # Test the body of the sent email contains what we expect it to
  #   assert_equal ['info@domici.ly'], email.from
  #   assert_equal [assignee.email], email.to
  #   assert_equal "Toegewezen: #{alert.title}", email.subject
  # end
