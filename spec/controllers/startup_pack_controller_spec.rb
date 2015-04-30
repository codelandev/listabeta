require 'spec_helper'

describe StartupPackController do
  context "User is signed in" do

    before do
      startup = Startup.make!
      sign_in startup
    end

    describe "GET pack" do
      it "renders sucessfully" do
        get :pack
        expect(response.status).to eql 200
      end
    end
    describe "GET confirm" do
      it "renders sucessfully" do
        get :confirm
        expect(response.status).to eql 200
      end
    end

    describe "POST dispatch_email" do
      before { Getup::Coupon.stub(:new_coupon).and_return('my-awesome-coupon') }

      it "creates a new subscription" do
        post :dispatch_email, subscriber: { "email" => "test@test.com", "newsletter_subscription" => "on" }
        subscriber = StartupPackSubscriber.last
        subscriber.email.should eql("test@test.com")
      end
    end
  end

  context "User is not signed in" do
    describe "GET pack" do
      it "renders sucessfully" do
        get :pack
        expect(response.status).to eql 200
      end
    end
    describe "GET confirm" do
      it "renders sucessfully" do
        get :confirm
        expect(response.status).to eql 200
      end
    end
  end
end
