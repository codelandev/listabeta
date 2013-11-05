class AddApprovatedToStartup < ActiveRecord::Migration
  def change
    add_column :startups, :approved, :boolean, default: false
  end
end
