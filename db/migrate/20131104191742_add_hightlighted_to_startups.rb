class AddHightlightedToStartups < ActiveRecord::Migration
  def change
    add_column :startups, :highlighted, :boolean, default: false
  end
end
