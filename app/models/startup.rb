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
  has_enumeration_for :phase, create_helpers: true

  has_many :questionnaires, dependent: :destroy

  mount_uploader :screenshot, ScreenshotUploader

  validates :email, :name, :website, :pitch, :description, :screenshot, :phase, :state, :city, :market_list,
            presence: true
  validates :website, url: true

  scope :highlighteds, -> { where(highlighted: true, status: Status::APPROVED).order('created_at DESC') }
  scope :unhighlighteds, -> { where(highlighted: false, status: Status::APPROVED).order('updated_at DESC') }
  scope :approvateds, -> { where(status: Status::APPROVED).order('created_at DESC') }
  scope :unapprovateds, -> { where(status: Status::UNAPPROVED).order('created_at DESC') }

  def highlight!
    update_column(:highlighted, true) and save
  end

  def unhighlight!
    update_column(:highlighted, false) and save
  end

  def approve!
    update_column(:status, Status::APPROVED) and save
    StartupMailer.notify_approvation(self).deliver
  end

  def unapprove!
    update_column(:status, Status::UNAPPROVED) and save
    StartupMailer.notify_unapprovation(self).deliver
  end
end
