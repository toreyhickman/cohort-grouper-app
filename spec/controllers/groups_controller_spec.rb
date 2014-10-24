require 'rails_helper'

describe GroupsController do
  let(:cohort) { create(:cohort) }
  let(:grouping) { Grouping.create(cohort_id: cohort.id) }
  let(:student) { create(:student) }

  context "without signing in" do
    describe "GET#new" do
      it "redirects to signin page" do
        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(response).to redirect_to signin_path
      end
    end
  end

  context "user signed in" do
    before(:each) do
      session[:github_token] = :token
      stub_dbc_api_cohort_response
    end

    describe "GET#new" do
      it "collects cohort into @cohort " do
        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(assigns(:cohort)).to eq cohort
      end

      it "calls for updating the cohort's students list" do
        expect(UpdateCohortStudentsList).to receive(:call).with(cohort) { [student] }

        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
      end

      it "collects proposed groups into @proposed_groups" do
        allow(Garoupa).to receive(:make_groups) { :garoupa_object }

        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(assigns(:proposed_groups)).to eq :garoupa_object
      end

      it "renders the new template" do
        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(response).to render_template :new
      end
    end
  end

end
