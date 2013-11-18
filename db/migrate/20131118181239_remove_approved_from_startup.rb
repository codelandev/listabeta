class RemoveApprovedFromStartup < ActiveRecord::Migration
  def change
    remove_column :startups, :approved
  end
end
