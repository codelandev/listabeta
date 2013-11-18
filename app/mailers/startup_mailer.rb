class StartupMailer < ActionMailer::Base
  default from: "no-reply@listabeta.com.br"

  def notify_approvation(startup)
    @startup = startup
    mail to: @startup.email, subject: 'Sua Startup está na Lista Beta!'
  end

  def notify_unapprovation(startup)
    @startup = startup
    mail to: @startup.email, subject: 'Sua Startup foi reprovada na Lista Beta!'
  end
end
