class NotificationMailer < ActionMailer::Base
  default from: "noreply@domici.ly"

  def comment_on_alert(alert, comment, user_email)
    @alert    = alert
    @comment  = comment
    @user_email     = user_email
    mail(bcc: @user_email, subject: "[Domici.ly] Reactie op #{@alert.title}", content_type: "text/html")
  end

  def invitees(event_id, group)
    mail(bcc: recipients_from_target_group(event_id, group), subject: "[Domici.ly] Uitnodiging voor #{event.title}", content_type: "text/html")
  end

  private

  def recipients_from_target_group(event, group)
    if group == 'everyone'
      return event.hoa.users.pluck(:email)
    elsif group == 'moderators'
      return User.with_role(:moderator, event.hoa).pluck(:email)
    else
      return 'job@jaxons.nl'
    end
  end
end
