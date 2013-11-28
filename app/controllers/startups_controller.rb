class StartupsController < InheritedResources::Base
  def index
    @startups = Startup.approvateds.order_by_approves
  end

  private

  def resource
    @startup ||= Startup.friendly.find(params[:id])
  end
end
