class Questionnaire < ActiveRecord::Base
  belongs_to :startup

  has_enumeration_for :a2
  has_enumeration_for :a3
  has_enumeration_for :a4
  has_enumeration_for :a5

  validates :startup_id, :a1, :a2, :a3, :a4, :a5, presence: true
  validates :email, uniqueness: { scope: :startup_id }, presence: true

  scope :total_for, ->(current_startup) { where(startup: current_startup).count }

  def self.to_csv
    CSV.generate do |csv|
      csv << ["email"]
      all.each do |questionnaire|
        csv << questionnaire.attributes.values_at(*["email"])
      end
    end
  end
end
