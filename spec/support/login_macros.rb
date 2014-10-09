module LoginMacros
  def signin
    allow(ValidateDevBootcampOwner).to receive(:call) { true }

    visit root_path
    setup_for_github_login_success
    click_link "Sign in with GitHub"
  end
end
