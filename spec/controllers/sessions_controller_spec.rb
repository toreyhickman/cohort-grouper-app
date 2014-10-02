require 'rails_helper'

describe SessionsController do
  describe "GET#new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST#create" do
    context "GitHub user a Devbootcamp org owner" do
      before(:each) do
        setup_for_github_login_success
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

        allow(ValidateDevBootcampOwner).to receive(:call) { true }
      end

      it "assigns the user's github token to the session" do
        session[:Github_token] = nil

        post :create, provider: :github
        expect(session[:github_token]).to eq OmniAuthMacros::MOCK_TOKEN
      end

      it "redirects to the cohort index page" do
        post :create, provider: :github
        expect(response).to redirect_to cohorts_path
      end
    end

    context "GitHub user not a Devbootcamp org owner" do
      before(:each) do
        setup_for_github_login_success
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

        allow(ValidateDevBootcampOwner).to receive(:call) { false }
      end

      it "redirects to the signin page" do
        post :create, provider: :github
        expect(response).to redirect_to signin_path
      end

      it "flashes an error message" do
        post :create, provider: :github
        expect(request.flash[:notice]).to eq "You're not a DevBootcamp employee."
      end

      it "does not assign the user's github token to the session" do
        session[:Github_token] = nil

        post :create, provider: :github
        expect(session[:github_token]).to be_nil
      end
    end
  end

  describe "POST#destroy" do
    it "clears the token from the session" do
      session[:github_token] = :token

      post :destroy
      expect(session[:github_token]).to be_nil
    end

    it "redirects to signin page" do
      post :destroy
      expect(response).to redirect_to signin_path
    end

    it "flashes a logout message" do
      post :destroy
      expect(request.flash[:notice]).to eq "You've successfully logged out."
    end
  end

  describe "GET#failure" do
    context "Failed login with GitHub" do
      before(:each) do
        setup_for_github_login_failure
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      end

      it "redirects to the signin page" do
        get :failure
        expect(response).to redirect_to signin_path
      end

      it "flashes failure message" do
        get :failure, message: OmniAuthMacros::MOCK_GITHUB_FAILURE_NOTICE
        expect(request.flash[:notice]).to eq OmniAuthMacros::MOCK_GITHUB_FAILURE_NOTICE
      end
    end
  end
end
