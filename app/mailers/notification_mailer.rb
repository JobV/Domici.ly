class NotificationMailer < ActionMailer::Base
  default from: "info@domici.ly"

  def comment_on_alert(alert, comment, user_email)
    @alert    = alert
    @comment  = comment
    @user_email     = user_email
    mail(to: @user_email, subject: "[Domici.ly] Reactie op #{@alert.title}")
  end
end
