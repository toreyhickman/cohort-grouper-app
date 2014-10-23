require 'rails_helper'

describe GroupsController do
  let(:cohort) { create(:cohort) }
  let(:grouping) { Grouping.create(cohort_id: cohort.id) }

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
    end

    describe "GET#new" do
      it "collects cohort into @cohort " do
        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(assigns(:cohort)).to eq cohort
      end

      it "renders the new template" do
        get :new, { cohort_id: cohort.slug, grouping_id: grouping.id }
        expect(response).to render_template :new
      end
    end
  end

end
