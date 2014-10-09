class RetrieveActiveCohorts

  extend DateDependent

  COHORTS_API_DOMAIN = "https://cohorts.devbootcamp.com/v1"
  COHORTS_API_AUTHORIZATION_HEADER = { :Authorization => "dbc-shared-secret #{ENV["DBC_SHARED_SECRET"]}" }

  def self.call
    case current_month
    when (1..2)  then active_cohorts(last_year, current_year)
    when (3..11) then active_cohorts(current_year)
    else              active_cohorts(current_year, next_year)
    end
  end

  private

  def self.active_cohorts(*years)
    active_cohorts_for_years = years.map do |year|
      url = active_cohorts_url(year)
      cohorts_api_response = request_active_cohorts(url)
      JSON[cohorts_api_response]
    end

    active_cohorts_for_years.reduce(:+)
  end

  def self.active_cohorts_url(year)
    RetrieveActiveCohorts::COHORTS_API_DOMAIN + "/cohorts/#{year}/active"
  end

  def self.request_active_cohorts(url)
    RestClient::Request.execute(
      { :method  => :get,
        :url     => url,
        :headers => RetrieveActiveCohorts::COHORTS_API_AUTHORIZATION_HEADER
      }
    )
  end
end
