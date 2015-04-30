require 'spec_helper'

describe Startup do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :website }
    it { should validate_presence_of :pitch }
    it { should validate_presence_of :description }
    it { should validate_presence_of :screenshot }
    it { should validate_presence_of :phase }
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
        @startup_1 = Startup.make!(highlighted: true, status: Status::APPROVED)
        @startup_2 = Startup.make!(highlighted: true)
        @startup_3 = Startup.make!(status: Status::APPROVED)
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
        @startup_1 = Startup.make!(status: Status::APPROVED)
        @startup_2 = Startup.make!(status: Status::APPROVED)
        @startup_3 = Startup.make!(highlighted: true, status: Status::APPROVED)
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
        @startup_1 = Startup.make!(status: Status::APPROVED)
        @startup_2 = Startup.make!(status: Status::APPROVED)
        @startup_3 = Startup.make!(status: Status::UNAPPROVED)
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
        @startup_1 = Startup.make!(status: Status::UNAPPROVED)
        @startup_2 = Startup.make!(status: Status::UNAPPROVED)
        @startup_3 = Startup.make!(status: Status::APPROVED)
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

      it "set highlighted_at to DateTime.now when unhighlighted" do
        expected = DateTime.now
        DateTime.stub(:now).and_return(expected)
        expect {
          @startup_unhighlight.highlight!
        }.to change(@startup_unhighlight, :highlighted_at).from(nil).to(expected)
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
        @approved_datetime ||= DateTime.new(2013, 11, 20, 12, 00)
        @startup_approved ||= Startup.make!(status: Status::APPROVED, approved_at: @approved_datetime)
      end

      context "startup is unapproved" do
        before { @startup_unapproved.approve! }

        it "change status to approved" do
          expect(@startup_unapproved.reload.status).to eql(Status::APPROVED)
        end

        it "approved_at is not nil" do
          expect(@startup_unapproved.reload.approved_at).to_not be_nil
        end

        it "approved_at is a Time" do
          expect(@startup_unapproved.reload.approved_at).to be_a(Time)
        end
      end

      context "already approved" do
        before { @startup_approved.approve! }

        it "continues with approved status" do
          expect(@startup_approved.reload.status).to eql(Status::APPROVED)
        end

        it "approved_at is not nil" do
          expect(@startup_approved.reload.approved_at).to_not be_nil
        end

        it "approved_at is a Time" do
          expect(@startup_approved.reload.approved_at).to be_a(Time)
        end

        it "approved_at is the old time" do
          expect(@startup_approved.reload.approved_at).to eq(@approved_datetime)
        end
      end

      it "send mail after approve!" do
        @startup_unapproved.approve!
        ActionMailer::Base.deliveries.last.to.should == [@startup_unapproved.email]
      end
    end

    context "#unapprove!" do
      before do
        @startup_unapproved ||= Startup.make!(status: Status::UNAPPROVED)
        @startup_approved   ||= Startup.make!(status: Status::APPROVED, approved_at: DateTime.now)
      end

      context "unnaproved startup" do
        before { @startup_unapproved.unapprove! }

        it "set when is approved" do
          expect(@startup_unapproved.reload.status).to eql(Status::UNAPPROVED)
        end

        it "sets nil on approved_at" do
          expect(@startup_unapproved.reload.approved_at).to be_nil
        end
      end

      context "approved startup" do
        before { @startup_approved.unapprove! }

        it "do nothing when already unapproved" do
          expect(@startup_approved.reload.status).to eql(Status::UNAPPROVED)
        end

        it "sets nil on approved_at" do
          expect(@startup_approved.reload.approved_at).to be_nil
        end
      end
    end
  end
end
