class StartupPackSubscriber < ActiveRecord::Base
  validates :email, presence: true
end
