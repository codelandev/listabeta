class PagesController < ApplicationController
  def home
  end

  def markets
    if params[:tag]
      @startups = Startup.tagged_with(params[:tag].gsub('-',' '), on: :markets)
    else
      @markets = Startup.tag_counts_on(:markets)
    end
  end
end
