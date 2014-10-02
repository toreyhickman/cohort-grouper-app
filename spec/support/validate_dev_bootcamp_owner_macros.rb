module ValidateDevBootcampOwnerMacros

  MOCK_GITHUB_TOKEN         = "1234567890"
  MOCK_GITHUB_USERNAME      = "github_user"
  MOCK_GITHUB_USER_ID       = 9876
  MOCK_DEV_BOOTCAMP_TEAM_ID = 123


  GITHUB_ACCESS_TOKEN_PARAM       = "access_token=#{ValidateDevBootcampOwnerMacros::MOCK_GITHUB_TOKEN}"


  GITHUB_DBC_TEAMS_ENDPOINT       = "https://api.github.com/orgs/devbootcamp/teams"
  GITHUB_GET_USER_ENDPOINT        = "https://api.github.com/user"
  GITHUB_TEAM_MEMBERSHIP_ENDPOINT = "https://api.github.com/teams/#{ValidateDevBootcampOwnerMacros::MOCK_DEV_BOOTCAMP_TEAM_ID}/memberships/#{ValidateDevBootcampOwnerMacros::MOCK_GITHUB_USERNAME}"


  MOCK_GITHUB_ACTIVE_TEAM_MEMBERSHIP  = "{\"state\":\"active\",\"url\":\"#{ValidateDevBootcampOwnerMacros::GITHUB_TEAM_MEMBERSHIP_ENDPOINT}\"}"
  MOCK_GITHUB_PENDING_TEAM_MEMBERSHIP = "{\"state\":\"pending\",\"url\":\"#{ValidateDevBootcampOwnerMacros::GITHUB_TEAM_MEMBERSHIP_ENDPOINT}\"}"
  MOCK_GITHUB_USER_RESPONSE = "{\"login\":\"#{ValidateDevBootcampOwnerMacros::MOCK_GITHUB_USERNAME}\",\"id\":#{ValidateDevBootcampOwnerMacros::MOCK_GITHUB_USER_ID}}"
  MOCK_DEV_BOOTCAMP_TEAMS = "[{\"name\":\"Owners\",\"id\":#{ValidateDevBootcampOwnerMacros::MOCK_DEV_BOOTCAMP_TEAM_ID},\"slug\":\"owners\",\"permission\":\"admin\",\"url\":\"https://api.github.com/teams/120899\",\"members_url\":\"https://api.github.com/teams/120899/members{/member}\",\"repositories_url\":\"https://api.github.com/teams/120899/repos\"},{\"name\":\"Admin\",\"id\":350799,\"slug\":\"admin\",\"permission\":\"admin\",\"url\":\"https://api.github.com/teams/350799\",\"members_url\":\"https://api.github.com/teams/350799/members{/member}\",\"repositories_url\":\"https://api.github.com/teams/350799/repos\"},{\"name\":\"Alpha Students\",\"id\":872037,\"slug\":\"alpha-students\",\"permission\":\"pull\",\"url\":\"https://api.github.com/teams/872037\",\"members_url\":\"https://api.github.com/teams/872037/members{/member}\",\"repositories_url\":\"https://api.github.com/teams/872037/repos\"}]"


  def stub_get_dbc_teams_error_response(options = {})
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_DBC_TEAMS_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: [403, "Unauthorized"])
  end

  def stub_get_dbc_teams_response
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_DBC_TEAMS_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: 200, body: ValidateDevBootcampOwnerMacros::MOCK_DEV_BOOTCAMP_TEAMS)
  end

  def stub_get_github_user_response
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_GET_USER_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: 200, body: ValidateDevBootcampOwnerMacros::MOCK_GITHUB_USER_RESPONSE)
  end

  def stub_get_team_membership_active_response
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_TEAM_MEMBERSHIP_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: 200, body: ValidateDevBootcampOwnerMacros::MOCK_GITHUB_ACTIVE_TEAM_MEMBERSHIP)
  end

  def stub_get_team_membership_pending_response
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_TEAM_MEMBERSHIP_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: 200, body: ValidateDevBootcampOwnerMacros::MOCK_GITHUB_PENDING_TEAM_MEMBERSHIP)
  end

  def stub_get_team_membership_error_response
    WebMock.stub_request(:get, "#{ValidateDevBootcampOwnerMacros::GITHUB_TEAM_MEMBERSHIP_ENDPOINT}?#{ValidateDevBootcampOwnerMacros::GITHUB_ACCESS_TOKEN_PARAM}").to_return(status: [404, "Not Found"])
  end
end
