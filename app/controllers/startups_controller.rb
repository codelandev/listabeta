class StartupsController < InheritedResources::Base
  def index
    @startups = Startup.approvateds
  end

  private

  def resource
    @startup ||= Startup.friendly.find(params[:id])
  end
end
