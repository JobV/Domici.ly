class SupportMailer < ActionMailer::Base
  def support_ticket(sender,text)
    @sender = sender
    @text   = text
    mail(from: sender.email, to: 'support@jaxons.nl', subject: "Domici.ly - #{sender.hoa_name} - #{sender.full_name}")
  end
end
