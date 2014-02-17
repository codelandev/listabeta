class StartupPackController < ApplicationController
  def pack
  end

  def confirm
  end

  def dispatch_email
    StartupPackSubscriber.create!(email: params[:subscriber][:email])
    redirect_to pack_path, notice: 'E-mail enviado com sucesso!'
  end
end
