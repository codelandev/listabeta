require 'spec_helper'

describe Questionnaire do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :a1 }
    it { should validate_presence_of :a2 }
    it { should validate_presence_of :a3 }
    it { should validate_presence_of :a4 }
    it { should validate_presence_of :a5 }
    it { should validate_uniqueness_of(:email).scoped_to(:startup_id) }
  end

  describe "Relations" do
    it { should belong_to :startup }
  end
end
