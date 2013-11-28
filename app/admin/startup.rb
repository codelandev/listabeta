ActiveAdmin.register Startup do
  controller do
    private

    def permitted_params
      params.permit(startup: [:email, :name, :website, :pitch, :description,
                              :screenshot, :status, :state, :city, :market_list,
                              :approved_at])
    end

    def resource
      @startup ||= Startup.friendly.find(params[:id])
    end
  end
  # Actions to highlight Startup
  member_action :highlight do
    Startup.friendly.find(params[:id]).highlight!
    flash[:notice] = "Startup posta em destaque com sucesso."
    redirect_to :back
  end

  member_action :unhighlight do
    Startup.friendly.find(params[:id]).unhighlight!
    flash[:notice] = "Startup tirada de destaque com sucesso."
    redirect_to :back
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Destacar", highlight_admin_startup_path if !startup.highlighted?
    end
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Tirar do destaque", unhighlight_admin_startup_path if startup.highlighted?
    end
  end

  # Actions to approve Startup
  member_action :approve do
    Startup.friendly.find(params[:id]).approve!
    flash[:notice] = "Startup aprovada com sucesso."
    redirect_to :back
  end

  member_action :unapprove do
    Startup.friendly.find(params[:id]).unapprove!
    flash[:notice] = "Startup desaprovada com sucesso."
    redirect_to :back
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    link_to "Aprovar", approve_admin_startup_path if startup.unapproved? || startup.pendent?
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    link_to "Desaprovar", unapprove_admin_startup_path if startup.approved? || startup.pendent?
  end

  index do
    column :id
    column :status do |startup|
      status_tag(Status.t(startup.status))
    end
    column :name
    column :website
    column :email
    default_actions
  end

  show do
    attributes_table do
      row :status do |startup|
        status_tag(Status.t(startup.status))
      end
      row :screenshot do |startup|
        link_to startup.screenshot, startup.screenshot_url, target: 'blank'
      end
      row :name
      row :phase do |startup|
        status_tag(Phase.t(startup.phase))
      end
      row :website do |startup|
        link_to startup.website, startup.website, target: 'blank'
      end
      row :pitch
      row :description
      row :email
      row :twitter do |startup|
        link_to startup.twitter, startup.twitter, target: 'blank'
      end
      row :state
      row :city
      row :markets do |startup|
        startup.market_list.each { |market| puts status_tag(market) }
      end
      row :highlighted do |startup|
        status_tag(startup.highlighted? ? 'Sim' : 'Não')
      end
      row :approved_at
    end
  end
end
