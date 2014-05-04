require 'test_helper'

class AnnouncementMailerTest < ActionMailer::TestCase
  require 'public_activity/testing'
  PublicActivity.enabled = false

  test 'announcement to everyone' do
    user = create(:user)
    hoa = create(:hoa)
    5.times { create(:user, hoa: hoa) }
    announcement = create(:announcement, hoa: hoa, user: user)

    email = AnnouncementMailer.announcement_to_group(announcement).deliver
    assert_not ActionMailer::Base.deliveries.empty?, 
      'Email should not be empty'

    assert_equal [user.email], email.from
    assert_equal 5, email.bcc.length
    assert_equal "[Domici.ly] Mededeling: #{announcement.title}", email.subject
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
    assert_equal "[Domici.ly] Mededeling: #{announcement.title}", email.subject
  end
end
