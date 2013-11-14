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
    it { should validate_presence_of :market_list }
  end

  describe "URL validation" do
    it { should allow_value('http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('http://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }

    it { should_not allow_value('lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value('lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.dehtml').for(:website) }
    it { should_not allow_value('http://lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value("\n").for(:website) }
    it { should_not allow_value('a space').for(:website) }
    it { should_not allow_value("blank\nline").for(:website) }
  end

  describe "Relations" do
    it { should have_many :questionnaires }
  end

  describe "Scopes" do
    context "#highlighted" do
      before do
        @startup_1 = Startup.make!(highlighted: true, approved: true)
        @startup_2 = Startup.make!(highlighted: true)
        @startup_3 = Startup.make!(approved: true)
      end

      it "return only the highlighted startups that are approved" do
        expect(Startup.highlighteds).to include(@startup_1)
        expect(Startup.highlighteds).to_not include(@startup_2)
      end

      it "doesn't include startups which are not highlighted" do
        expect(Startup.highlighteds).to_not include(@startup_3)
      end
    end

    context "#unhighlighted" do
      before do
        @startup_1 = Startup.make!(approved: true)
        @startup_2 = Startup.make!(approved: true)
        @startup_3 = Startup.make!(highlighted: true, approved: true)
      end

      it "return only the unhighlighted startups" do
        expect(Startup.unhighlighteds).to include(@startup_1)
        expect(Startup.unhighlighteds).to include(@startup_2)
      end

      it "doesn't include startups which are highlighted" do
        expect(Startup.unhighlighteds).to_not include(@startup_3)
      end
    end

    context "#approved" do
      before do
        @startup_1 = Startup.make!(approved: true)
        @startup_2 = Startup.make!(approved: true)
        @startup_3 = Startup.make!
      end

      it "return only the approved startups" do
        expect(Startup.approvateds).to include(@startup_1)
        expect(Startup.approvateds).to include(@startup_2)
      end

      it "doesn't include startups which are not approvateds" do
        expect(Startup.approvateds).to_not include(@startup_3)
      end
    end

    context "#unapproved" do
      before do
        @startup_1 = Startup.make!
        @startup_2 = Startup.make!
        @startup_3 = Startup.make!(approved: true)
      end

      it "return only the unhighlighted startups" do
        expect(Startup.unapprovateds).to include(@startup_1)
        expect(Startup.unapprovateds).to include(@startup_2)
      end

      it "doesn't include startups which are approvateds" do
        expect(Startup.unapprovateds).to_not include(@startup_3)
      end
    end
  end

  describe "Methods" do
    context "#highlight!" do
      before do
        @startup_unhighlight ||= Startup.make!
        @startup_highlight   ||= Startup.make!(highlighted: true)
      end

      it "set when is unhighlighted" do
        @startup_unhighlight.highlight!
        expect(@startup_unhighlight.highlighted).to be_true
      end

      it "do nothing when already highlighted" do
        @startup_highlight.highlight!
        expect(@startup_highlight.highlighted).to be_true
      end
    end

    context "#unhighlight!" do
      before do
        @startup_unhighlight ||= Startup.make!
        @startup_highlight   ||= Startup.make!(highlighted: true)
      end

      it "set when is highlighted" do
        @startup_highlight.unhighlight!
        expect(@startup_highlight.highlighted).to be_false
      end

      it "do nothing when already unhighlighted" do
        @startup_highlight.unhighlight!
        expect(@startup_highlight.highlighted).to be_false
      end
    end

    context "#approve!" do
      before do
        @startup_unapproved ||= Startup.make!
        @startup_approved   ||= Startup.make!(approved: true)
      end

      it "set when is unapproved" do
        @startup_unapproved.approve!
        expect(@startup_unapproved.approved).to be_true
      end

      it "do nothing when already approved" do
        @startup_approved.approve!
        expect(@startup_approved.approved).to be_true
      end

      it "send mail after approve!" do
        @startup_unapproved.approve!
        ActionMailer::Base.deliveries.last.to.should == [@startup_unapproved.email]
      end
    end

    context "#unapprove!" do
      before do
        @startup_unapproved ||= Startup.make!
        @startup_approved   ||= Startup.make!(approved: true)
      end

      it "set when is approved" do
        @startup_approved.unapprove!
        expect(@startup_approved.approved).to be_false
      end

      it "do nothing when already unapproved" do
        @startup_approved.unapprove!
        expect(@startup_approved.approved).to be_false
      end
    end
  end
end
