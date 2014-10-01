module OmniAuthMacros

  MOCK_TOKEN = "12345"
  MOCK_GITHUB_USERNAME = "github_user"
  MOCK_GITHUB_FAILURE_NOTICE = "GitHub login failure"

  def setup_for_github_login_success
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      'provider'    => 'github',
      'credentials' => { 'token' => OmniAuthMacros::MOCK_TOKEN },
      'info'        => { 'nickname' => OmniAuthMacros::MOCK_GITHUB_USERNAME }
    })

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    return nil
  end

  def setup_for_github_login_failure
    OmniAuth.config.mock_auth[:github] = OmniAuthMacros::MOCK_GITHUB_FAILURE_NOTICE.to_sym

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    return nil
  end
end
