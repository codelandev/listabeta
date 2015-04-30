ActiveAdmin.register Questionnaire do
  index do
    selectable_column
    column :id
    column :email
    column :startup do |questionnaire|
      questionnaire.startup.name
    end
    column :created_at
    default_actions
  end
end
