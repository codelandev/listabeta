class StartupsController < InheritedResources::Base
  def index
    @startups = Startup.approvateds.order_by_approves.page(params[:page]).per(4)
  end

  private

  def resource
    @startup ||= Startup.friendly.find(params[:id])
  end
end
