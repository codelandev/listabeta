require 'spec_helper'

describe QuestionnairesController do
  context "When logged in" do
    let(:startup) { Startup.make!(status: Status::APPROVED) }
    let(:questionnaire) { Questionnaire.make!(startup: startup) }
    let(:questionnaire_with_different_id) { Questionnaire.make! }

    let(:valid_attributes) { {
      # "startup_id" => startup.id,
      "email" => "feedback@test.com",
      "a1" => "text",
      "a2" => A2::N,
      "a3" => A3::N,
      "a4" => A4::N,
      "a5" => A5::RANGE1,
      "opinion" => "text"
    } }

    let(:invalid_attributes) { {
      # "email" => "feedback@test.com",
      "a1" => "text",
      "a2" => A2::N,
      "a3" => A3::N,
      "a4" => A4::N,
      "a5" => A5::RANGE1,
      "opinion" => "text"
    } }

    before do
      sign_in startup
    end

    describe "GET 'edit'" do
      it "returns http error" do
        expect(:get => "/edit").not_to be_routable
      end
    end

    describe "GET 'new'" do
      it "returns http success when pass startup_id" do
        get :new, startup_id: startup.id
        response.should be_success
      end

      it "returns http error when not pass startup_id" do
        expect(:get => "/edit").not_to be_routable
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        expect {
          post :create, startup_id: startup.slug, questionnaire: valid_attributes
        }.to change(Questionnaire, :count).by(1)
      end

      it "returns http error" do
        expect {
          post :create, startup_id: startup.slug, questionnaire: invalid_attributes
        }.to change(Questionnaire, :count).by(0)
      end
    end
  end
end
