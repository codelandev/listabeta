require 'spec_helper'

describe ApplicationController do
  describe "#configure_permitted_parameters" do
    before do
      subject.stub(:resource_class).and_return(Startup)
      subject.stub(:resource_name).and_return("Startup")
      subject.__send__(:configure_permitted_parameters)
    end

    context "devise_parameter_sanitizer for sign_up" do
      it { controller.devise_parameter_sanitizer.for(:sign_up).should include(:email) }
    end

    context "devise_parameter_sanitizer for :sign_in" do
      it { controller.devise_parameter_sanitizer.for(:sign_in).should include(:email) }
    end

    context "devise_parameter_sanitizer for :account_update" do
      it { controller.devise_parameter_sanitizer.for(:account_update).should include(:email) }
    end
  end
end
