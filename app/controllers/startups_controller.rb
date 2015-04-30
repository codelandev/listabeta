class StartupsController < InheritedResources::Base
  def index
    @startups = Startup.approvateds.order_by_approves.page(params[:page]).per(15)
  end

  def show
    if resource.status.eql?(2)
      show!
    else
      redirect_to root_path, notice: 'Essa startup ainda não está disponível.'
    end
  end

  private

  def resource
    @startup ||= Startup.friendly.find(params[:id])
  end
end
