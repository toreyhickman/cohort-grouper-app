class ValidateDevBootcampOwner

  GITHUB_API_DOMAIN = "https://api.github.com"

  def self.call(token)
    # Get username based on token /user
    # Get DBC Owners team id
    # Check if user is member of Owners /teams/:team_id/memberships/:username

    unless team_id = devbootcamp_owners_team_id(token)
      return false
    end

    username = github_username(token)

    dev_bootcamp_owner? username, team_id, token
  end

  private

  def self.make_get_request(path, token)
    RestClient.get "#{GITHUB_API_DOMAIN}" + path, params: { access_token: token }
  end

  def self.github_username(token)
    response = make_get_request "/user", token
    JSON[response]["login"]
  end

  def self.devbootcamp_owners_team_id(token)
    begin
      response = make_get_request "/orgs/devbootcamp/teams", token
    rescue
      return nil
    end

    JSON[response].find { |team| team["name"] == "Owners" }["id"]
  end

  def self.dev_bootcamp_owner?(username, dbc_owners_team_id, token)
    begin
      response = make_get_request "/teams/#{dbc_owners_team_id}/memberships/#{username}", token
    rescue
      return false
    end

    JSON[response]["state"] == "active"
  end
end
