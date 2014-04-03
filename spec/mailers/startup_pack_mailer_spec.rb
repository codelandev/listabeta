require "spec_helper"

describe StartupPackMailer do
  describe "offers_email" do
    before { Getup::Coupon.stub(:new_coupon).and_return('my-awesome-coupon') }

    let(:mail) { StartupPackMailer.offers_email("test@test.com") }

    it "sends the email to the received address" do
      mail.to.should.eql?("test@test.com")
    end

    it "renders the sender email" do
      mail.from.should.eql?("contato@listabeta.com.br")
    end
  end
end
