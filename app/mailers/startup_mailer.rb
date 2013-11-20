class StartupMailer < ActionMailer::Base
  default from: "noreply@listabeta.com.br"

  def notify_approvation(startup)
    @startup = startup
    mail to: @startup.email, subject: 'Aprovação no LISTABETA'
  end

  def notify_unapprovation(startup)
    @startup = startup
    mail to: @startup.email, subject: 'Reprovação na LISTABETA!'
  end
end
