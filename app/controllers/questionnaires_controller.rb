class QuestionnairesController < InheritedResources::Base
  actions :create, :new
  belongs_to :startup, param: :startup_id

  def new
    if resource.status.eql?(2)
      set_meta_tags noindex: true, nofollow: true
      @questionnaire = Questionnaire.new
      @startup = resource
      new!
    else
      redirect_to root_path, notice: 'Essa startup ainda não está disponível.'
    end
  end

  def create
    set_meta_tags noindex: true, nofollow: true
    @questionnaire = Questionnaire.new(permitted_params[:questionnaire])
    @questionnaire.startup_id = resource.id
    create!(notice: I18n.t('flash.questionnaires.send_success')) { root_path }
  end

  protected

  def resource
    @startup ||= Startup.friendly.find(params[:startup_id])
  end

  private

  def permitted_params
    params.permit(questionnaire: [:email, :opinion, :a1, :a2, :a3, :a4, :a5])
  end
end
