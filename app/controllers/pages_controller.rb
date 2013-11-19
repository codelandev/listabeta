class PagesController < ApplicationController
  before_action :authenticate_startup!, only:[:dashboard]
  
  def home
    @highlighteds = Startup.highlighteds
    @unhighlighteds = Startup.unhighlighteds
  end

  def markets
    if params[:tag]
      @startups = Startup.tagged_with(params[:tag].gsub('-',' '), on: :markets)
    else
      @markets = Startup.tag_counts_on(:markets)
    end
  end

  def dashboard
    set_meta_tags noindex: true, nofollow: true

    @feedbacks_total = Questionnaire.total_for(current_startup)
    @all_questionnaires = Questionnaire.where(startup: current_startup)
    @count_last_seven_days_for = Questionnaire.where(startup: current_startup).group_by_day(:created_at).limit(7).count
    @a2 = Hash[Questionnaire.where(startup: current_startup).group('a2').count.map { |key, value| [A2::t(key), value] }]
    @a3 = Hash[Questionnaire.where(startup: current_startup).group('a3').count.map { |key, value| [A3::t(key), value] }]
    @a4 = Hash[Questionnaire.where(startup: current_startup).group('a4').count.map { |key, value| [A4::t(key), value] }]
    @a5 = Hash[Questionnaire.where(startup: current_startup).group('a5').count.map { |key, value| [A5::t(key), value] }]

    respond_to do |format|
      format.html
      format.csv { send_data @all_questionnaires.to_csv, :disposition => "attachment; filename=#{Date.today.strftime('%d-%m-%Y')}-emails.csv" }
    end
  end
end
