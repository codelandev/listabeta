class AddHighlightedAtToStartups < ActiveRecord::Migration
  def self.up
    add_column :startups, :highlighted_at, :datetime
    Startup.where(highlighted: true).each do |startup|
      startup.update_column(:highlighted_at, DateTime.now)
    end
  end

  def self.down
    remove_column :startups, :approved_at
  end
end
