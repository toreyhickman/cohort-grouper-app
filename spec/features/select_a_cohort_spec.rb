require 'rails_helper'

feature "select a cohort for which to make groups" do
  context "user not signed in" do
    scenario "user attemtps to view cohorts without signing in" do
      visit cohorts_path
      expect(page).to have_content "Sign in with GitHub"
    end
  end

  context "user logged in" do
    let(:expected_chicago_cohort_names) { RetrieveActiveCohortsMacros::MOCK_ACTIVE_CHICAGO_COHORT_NAMES_2014 }
    let(:expected_san_francisco_cohort_names) { RetrieveActiveCohortsMacros::MOCK_ACTIVE_SAN_FRANCISCO_COHORT_NAMES_2014 }

    let(:unexpected_cohort_names) do
      RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORT_NAMES_2013 + RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORT_NAMES_2015
    end

    background do
      allow(Date).to receive(:today) { Date.new(2014, 04, 15) }
      stub_get_active_cohorts_2014

      signin
    end

    scenario "user selects a cohort for which to make groups" do
      visit cohorts_path

      expect(page).to have_content "Cohorts"

      # Ensure only approriate cohorts are displayed
      (expected_san_francisco_cohort_names + expected_chicago_cohort_names).each do |cohort_name|
        expect(page).to have_content cohort_name
      end

      unexpected_cohort_names.each do |cohort_name|
        expect(page).to_not have_content cohort_name
      end

      RetrieveActiveCohortsMacros::LOCATIONS_WITH_MOCK_COHORTS.each do |location|
        expect(page).to have_content location
      end

      # Find cohorts under their locations
      within('#chicago-cohorts') do
        expected_chicago_cohort_names.each do |cohort_name|
          expect(page).to have_content cohort_name
        end
      end


      click_link "Otters"

      expect(page).to have_content "Otters"
    end
  end
end
