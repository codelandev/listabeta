class Startup < ActiveRecord::Base
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  friendly_id :name, use: :slugged

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :markets

  has_enumeration_for :status, create_helpers: true

  mount_uploader :screenshot, ScreenshotUploader

  validates :email, :name, :website, :pitch, :description, :screenshot, :status, :state, :city, :market_list,
            presence: true
  validates :website, url: true

  scope :highlighteds, -> { where(highlighted: true, approved: true).order(:created_at) }
  scope :unhighlighteds, -> { where(highlighted: false, approved: true).order(:created_at) }
  scope :approvateds, -> { where(approved: true).order(:created_at) }
  scope :unapprovateds, -> { where(approved: false).order(:created_at) }

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
