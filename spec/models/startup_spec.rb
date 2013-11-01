require 'spec_helper'

describe Startup do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :website }
    it { should validate_presence_of :pitch }
    it { should validate_presence_of :description }
    it { should validate_presence_of :screenshot }
    it { should validate_presence_of :status }
    it { should validate_presence_of :state }
    it { should validate_presence_of :city }
    it { should validate_presence_of :markets }
  end

  describe "URL validation" do
    it { should allow_value('http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('http://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }

    it { should_not allow_value('lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value('lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value('http://lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value("\n").for(:website) }
    it { should_not allow_value('a space').for(:website) }
    it { should_not allow_value("blank\nline").for(:website) }
  end
end
