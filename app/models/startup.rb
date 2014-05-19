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

  scope :highlighteds, -> { where(highlighted: true, status: Status::APPROVED) }
  scope :unhighlighteds, -> { where(highlighted: false, status: Status::APPROVED) }
  scope :approvateds, -> { where(status: Status::APPROVED) }
  scope :unapprovateds, -> { where(status: Status::UNAPPROVED) }
  scope :order_by_approves, -> { order("approved_at DESC") }
  scope :order_by_highlighted_at, -> { order ("highlighted_at DESC")}

  def highlight!
    self.update_column(:highlighted, true)
    self.highlighted_at = DateTime.now
    save
  end

  def unhighlight!
    update_column(:highlighted, false) and save
  end

  def approve!
    return if status.eql?(Status::APPROVED)
    self.status = Status::APPROVED
    self.approved_at = DateTime.now
    StartupMailer.notify_approvation(self).deliver if save
  end

  def unapprove!
    self.status = Status::UNAPPROVED
    self.approved_at = nil
    StartupMailer.notify_unapprovation(self).deliver if save
  end
end
