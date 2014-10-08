require 'rails_helper'

describe ApplicationController do
  describe "helper methods" do
    controller do
      def index
        render nothing: true
      end
    end

    before(:each) { get :index }

    describe "#signed_in?" do
      context "when github_token is added to the session" do
        it "returns true" do
          session[:github_token] = "12345"
          expect(controller.signed_in?).to eq true
        end
      end

      context "when github_token not added to the session" do
        it "returns false" do
          session[:github_token] = nil
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
end
