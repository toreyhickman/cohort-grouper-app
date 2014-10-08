require 'rails_helper'

describe ApplicationController do
  describe "helper methods" do
    controller do
      def index
        render nothing: true
      end
    end

    describe "#signed_in?" do
      context "when github_token is added to the session" do
        it "returns true" do
          get :index, nil, { github_token: "12345" }
          expect(controller.signed_in?).to eq true
        end
      end

      context "when github_token not added to the session" do
        it "returns false" do
          get :index, nil, { github_token: nil }
          expect(controller.signed_in?).to eq false
        end
      end
    end

    describe "#current_token" do
      it "returns the value of github_token in session" do
        session[:github_token] = "abc"
        expect(controller.current_token).to eq "abc"
      end
    end
  end


  describe "before_filters" do
    controller do
      def index
        render nothing: true
      end
    end

    describe "#ensure_signin" do
      context "user signed in" do
        it "does not redirect to signin page" do
          get :index, nil, { github_token: "12345" }
          expect(response.status).to eq 200
        end
      end

      context "user not signed in" do
        it "redirects to signin page" do
          get :index, nil, { github_token: nil }
          expect(response).to redirect_to signin_path
        end
      end
    end
  end
end
