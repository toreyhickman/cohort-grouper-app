module OmniAuthMacros

  MOCK_TOKEN = "12345"
  MOCK_GITHUB_USERNAME = "github_user"

  def setup_for_github_login_success
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      'credentials' => { 'token' => OmniAuthMacros::MOCK_TOKEN },
      'info'        => { 'nickname' => OmniAuthMacros::MOCK_GITHUB_USERNAME }
    })
  end

  def setup_for_github_login_failure
    OmniAuth.config.mock_auth[:github] = :github_login_failure
  end
end
