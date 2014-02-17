require 'spec_helper'

describe StartupPackController do
  context "User is signed in" do
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
