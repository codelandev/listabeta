class StartupPackController < ApplicationController
  def pack
  end

  def confirm
  end

  def confirmed
  end

  def dispatch_email
    if params[:subscriber][:email].empty?
      redirect_to :back, alert: "E-mail não pode ficar em branco."
    else
      StartupPackSubscriber.create!(email: params[:subscriber][:email],
                                    newsletter_subscription: params[:subscriber][:newsletter_subscription])
      StartupPackMailer.offers_email(params[:subscriber][:email]).deliver
      redirect_to confirmed_pack_path, notice: 'E-mail enviado com sucesso!'
    end
  end
end
