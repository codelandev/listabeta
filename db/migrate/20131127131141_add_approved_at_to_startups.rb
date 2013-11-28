class AddApprovedAtToStartups < ActiveRecord::Migration
  def self.up
    add_column :startups, :approved_at, :datetime
    Startup.where(status: Status::APPROVED).each do |startup|
      startup.update_column(:approved_at, DateTime.now)
    end
  end

  def self.down
    remove_column :startups, :approved_at
  end
end
