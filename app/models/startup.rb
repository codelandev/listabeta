class Startup < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_enumeration_for :status, create_helpers: true

  mount_uploader :screenshot, ScreenshotUploader

  validates :email, :name, :website, :pitch, :description, :screenshot, :status, :state, :city, :markets,
            presence: true
  validates :website, url: true

  scope :highlighteds, -> { where(highlighted: true) }
  scope :unhighlighteds, -> { where(highlighted: false) }

  def highlight!
    update_column(:highlighted, true) and save
  end

  def unhighlight!
    update_column(:highlighted, false) and save
  end
end
