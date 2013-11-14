ActiveAdmin.register Startup do
  controller do
    private

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
    edirect_to :back
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
    unless startup.approved.nil?
      link_to "Aprovar", approve_admin_startup_path if !startup.approved?
    end
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    unless startup.approved.nil?
      link_to "Desaprovar", unapprove_admin_startup_path if startup.approved?
    end
  end

  index do
    column :id
    column :name
    column :website
    column :email
    default_actions
  end

  show do
    attributes_table do
      row :screenshot
      row :name
      row :website
      row :pitch
      row :description
      row :email
      row :twitter
      row :state
      row :city
      row :markets
      row :approved
      row :highlighted
    end
  end
end
