require 'spec_helper'

describe QuestionnairesController do
  context "When logged in" do  
    let(:startup) { Startup.make! }
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

    describe "GET 'index'" do
      it "assigns only my startups" do
        @my_questionnaires = []
        
        2.times do
          @my_questionnaires << Questionnaire.make!(startup: startup)
        end
        
        get :index, startup_id: startup.slug

        assigns(:my_questionnaires).should =~ @my_questionnaires
        response.should be_success
      end
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

    describe "GET 'show'" do
      it "returns http success" do
        get :show, startup_id: questionnaire.startup.id, id: questionnaire.to_param
        response.should be_success
      end

      it "return http redirect" do
        get :show, startup_id: questionnaire_with_different_id.startup.id, id: questionnaire_with_different_id.to_param
        response.should redirect_to startup_questionnaires_path
      end
    end
  end
end
