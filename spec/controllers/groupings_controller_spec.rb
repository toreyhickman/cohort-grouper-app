require 'rails_helper'

describe GroupingsController do
  let(:cohort) { create(:cohort) }

  context "without signing in" do
    describe "POST#create" do
      it "redirects to signin page" do
        post :create, { cohort_id: cohort.id }
        expect(response).to redirect_to signin_path
      end
    end
  end

  context "user signed in" do
    before(:each) do
      session[:github_token] = :token
    end

    describe "POST#create" do
      it "creates a new grouping record belonging to the cohort" do
        expect{ post :create, { cohort_id: cohort.slug } }.to change{ cohort.groupings.count }.by(1)
      end

      it "redirects to page for making new groups for the new grouping" do
        post :create, { cohort_id: cohort.slug }
        new_grouping = Grouping.last

        expect(response).to redirect_to new_cohort_grouping_group_path(cohort, new_grouping)
      end
    end
  end
end
