class QuestionnairesController < InheritedResources::Base
  actions :create, :new
  belongs_to :startup, param: :startup_id
  before_filter :authenticate_startup!, only:[:index, :show]

  def index
    @my_questionnaires = Questionnaire.where(startup_id: current_startup)
  end

  def new
    @questionnaire = Questionnaire.new
    @startup = resource
    new!
  end

  def create
    @questionnaire = Questionnaire.new(permitted_params[:questionnaire])
    @questionnaire.startup_id = resource.id
    create!(notice: I18n.t('flash.questionnaires.send_success')) { root_path }
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.startup != current_startup
      redirect_to startup_questionnaires_path, alert: I18n.t('flash.questionnaires.unauthorized_access')
    else
      @questionnaire
    end
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
