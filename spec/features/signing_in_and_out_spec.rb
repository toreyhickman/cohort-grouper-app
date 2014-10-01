require 'rails_helper'

feature "GitHub Authentication through OmniAuth" do
  context "user is a member of DevBootcamp's owners team" do
    let(:devbootcamp_owner) { double(devbootcamp_owner?: true) }

    background do
      allow(GitHubUser).to receive(:new) { devbootcamp_owner }
    end

    scenario "GitHub signin successful and then signs out" do
      visit root_path

      setup_for_github_login_success
      click_link "Sign in with GitHub"

      expect(page).to have_content "Cohorts"

      click_link "sign out"

      expect(page).to have_content "Sign in with GitHub"
    end

    scenario "GitHub signin fails" do
      visit root_path

      setup_for_github_login_failure
      click_link "Sign in with GitHub"

      expect(page).to have_content "Sign in with GitHub"
      expect(page).to have_content OmniAuthMacros::MOCK_GITHUB_FAILURE_NOTICE
    end
  end

  context "user is not a member of DevBootcamp's owners team" do
    let(:not_devbootcamp_owner) { double(devbootcamp_owner?: false) }

    background do
      allow(GitHubUser).to receive(:new) { not_devbootcamp_owner }
    end

    scenario "GitHub sign in successful but not authorized" do
      visit root_path

      setup_for_github_login_success
      click_link "Sign in with GitHub"

      expect(page).to have_content "Sign in with GitHub"
      expect(page).to have_content "You're not a DevBootcamp employee."
    end

    scenario "GitHub signin fails" do
      visit root_path

      setup_for_github_login_failure
      click_link "Sign in with GitHub"

      expect(page).to have_content "Sign in with GitHub"
      expect(page).to have_content OmniAuthMacros::MOCK_GITHUB_FAILURE_NOTICE
    end
  end

end
