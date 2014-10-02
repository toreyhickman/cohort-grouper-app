require 'rails_helper'

describe ValidateDevBootcampOwner do
  describe ".call" do
    context "user cannot retrieve DevBootcamp organization teams" do

      it "returns false" do
        stub_get_dbc_teams_error_response
        expect(ValidateDevBootcampOwner.call(ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN)).to be false
      end

      it "returns after failed attempt to get DevBootcamp owners team id" do
        stub_get_dbc_teams_error_response

        expect(ValidateDevBootcampOwner).to_not receive(:github_username)
        ValidateDevBootcampOwner.call(ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN)
      end
    end

    context "user can retrieve DevBootcamp organization teams" do
      before do
        stub_get_dbc_teams_response
        stub_get_github_user_response
      end

      context "user is active member of DevBootcamp Owners team" do
        it "returns true" do
          stub_get_team_membership_active_response
          expect(ValidateDevBootcampOwner.call(ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN)).to be true
        end
      end

      context "user is pending member of DevBootcamp Owners team" do
        it "returns false" do
          stub_get_team_membership_pending_response
          expect(ValidateDevBootcampOwner.call(ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN)).to be false
        end
      end

      context "user is not a member of Devbootcamp Owners team" do
        it "returns false" do
          stub_get_team_membership_error_response
          expect(ValidateDevBootcampOwner.call(ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN)).to be false
        end
      end
    end
  end
end
