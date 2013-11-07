class Startup < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :markets

  has_enumeration_for :status, create_helpers: true

  mount_uploader :screenshot, ScreenshotUploader

  validates :email, :name, :website, :pitch, :description, :screenshot, :status, :state, :city, :market_list,
            presence: true
  validates :website, url: true

  scope :highlighteds, -> { where(highlighted: true, approved: true) }
  scope :unhighlighteds, -> { where(highlighted: false, approved: true) }
  scope :approvateds, -> { where(approved: true) }
  scope :unapprovateds, -> { where(approved: false) }

  def highlight!
    update_column(:highlighted, true) and save
  end

  def unhighlight!
    update_column(:highlighted, false) and save
  end

  def approve!
    update_column(:approved, true) and save
    StartupMailer.notify_approvation(self).deliver
  end

  def unapprove!
    update_column(:approved, false) and save
  end
end
