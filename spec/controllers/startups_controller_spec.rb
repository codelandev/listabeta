require 'spec_helper'

describe StartupsController do
  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:startup) { Startup.make! }
    it "returns http success" do
      get :show, id: startup.to_param
      response.should be_success
    end
  end
end
