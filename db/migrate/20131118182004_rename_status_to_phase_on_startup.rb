class RenameStatusToPhaseOnStartup < ActiveRecord::Migration
  def change
    # removed because it's a boolean and we need an integer
    remove_column :startups, :status
    add_column :startups, :phase, :integer, null: false, default: 1
    add_column :startups, :status, :integer, null: false, default: 1
  end
end
