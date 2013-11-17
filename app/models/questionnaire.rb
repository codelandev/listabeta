class Questionnaire < ActiveRecord::Base
  belongs_to :startup

  has_enumeration_for :a2
  has_enumeration_for :a3
  has_enumeration_for :a4
  has_enumeration_for :a5

  validates :startup_id, :a1, :a2, :a3, :a4, :a5, :opinion, presence: true
  validates :email, uniqueness: true, presence: true

  scope :total_for, ->(current_startup) { where(startup: current_startup).count }
end
