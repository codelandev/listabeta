class StartupPackMailer < ActionMailer::Base
  default from: "contato@listabeta.com.br"

  def offers_email(email)
    @email = email
    @coupon_code = Getup::Coupon.create_new_coupon
    mail to: email, subject: "Aqui está o seu LISTABETA STARTUP PACK"
  end
end
