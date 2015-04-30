class CreateStartupPackSubscribers < ActiveRecord::Migration
  def change
    create_table :startup_pack_subscribers do |t|
      t.string :email

      t.timestamps
    end
  end
end
