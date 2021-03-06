require 'rails_helper'

describe CohortsController do
  let(:cohort) { create(:cohort) }

  context "without signing in" do
    describe "GET#index" do
      it "redirects to signin page" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end

    describe "GET#show" do
      it "redirects to signin page" do
        get :show, id: cohort
        expect(response).to redirect_to signin_path
      end
    end
  end

  context "user signed in" do
      before(:each) do
        session[:github_token] = :token
      end

      describe "GET#index" do
        let(:cohort) { create(:cohort) }

        before(:each) do
          allow(RetrieveActiveCohorts).to receive(:call) { [{ "name" => "Otters 2014", "slug" => "otters-2014", "location" => "Chicago" }] }
        end

        it "renders the index template" do
          get :index
          expect(response).to render_template :index
        end

        it "collects active cohorts into @cohorts" do
          expected_cohorts = [cohort]
          get :index
          expect(assigns(:cohorts)).to match_array expected_cohorts
        end

        it "saves cohorts to the database" do
          expect { get :index }.to change {Cohort.count}.by(1)
        end

        it "saves only new cohorts to the database" do
          cohort
          expect { get :index }.to_not change { Cohort.count }
        end

        it "collects cohort locations into @locations" do
          allow(Cohort).to receive(:locations) { ["Chicago", "New York"] }

          get :index
          expect(assigns(:locations)).to match_array ["Chicago", "New York"]
        end
      end

    describe "GET#show" do
      let(:cohort) { create(:cohort) }

      it "renders the show template" do
        get :show, id: cohort
        expect(response).to render_template :show
      end

      it "collects cohort identified in url into @cohort" do
        get :show, id: cohort
        expect(assigns(:cohort)).to eq cohort
      end
    end
  end
end
