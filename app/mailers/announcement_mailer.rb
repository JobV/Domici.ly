class AnnouncementMailer < ActionMailer::Base
  default from: "noreply@domici.ly"

  def announcement_to_group(announcement)
    @announcement = announcement
    mail(bcc: recipients_from_target_group, subject: "[Domici.ly] Mededeling: #{@announcement.title}", from: announcement.user.email)
  end

  private

  def recipients_from_target_group
    if @announcement.target_group == 'everyone'
      return @announcement.hoa.users.pluck(:email)
    elsif @announcement.target_group == 'moderators'
      return User.with_role(:moderator, @announcement.hoa).pluck(:email)
    end
  end
end
