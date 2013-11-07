class StartupsController < InheritedResources::Base
  private

  def resource
    @startup ||= Startup.friendly.find(params[:id])
  end
end
