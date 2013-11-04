ActiveAdmin.register Startup do
  member_action :highlight do
    Startup.find(params[:id]).highlight!
    flash[:notice] = "Startup posta em destaque com sucesso."
    redirect_to :back
  end

  member_action :unhighlight do
    Startup.find(params[:id]).unhighlight!
    flash[:notice] = "Startup tirada de destaque com sucesso."
    redirect_to :back
  end

  action_item only: :show do
    startup = Startup.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Destacar", highlight_admin_startup_path if !startup.highlighted?
    end
  end

  action_item only: :show do
    startup = Startup.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Tirar do destaque", unhighlight_admin_startup_path if startup.highlighted?
    end
  end

  index do
    column :id
    column :name
    column :website
    column :email
    default_actions
  end
end
