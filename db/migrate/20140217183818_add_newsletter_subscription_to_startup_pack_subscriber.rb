class AddNewsletterSubscriptionToStartupPackSubscriber < ActiveRecord::Migration
  def change
    add_column :startup_pack_subscribers, :newsletter_subscription, :boolean, default: true
  end
end
