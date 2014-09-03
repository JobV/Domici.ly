class AssignmentMailer < ActionMailer::Base
  default from: "noreply@domici.ly"

  def assigned_to_alert(assigner, assignee, alert)
    @assigner = assigner
    @assignee = assignee
    @alert    = alert
    mail(to: assignee.email, subject: "Toegewezen: #{alert.title}")
  end
end
