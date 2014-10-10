module RetrieveActiveCohortsMacros

  LOCATIONS_WITH_MOCK_COHORTS = ["Chicago", "San Francisco"]

  # 2013
  MOCK_ACTIVE_COHORT_NAMES_2013 = ["Bison"]

  DBC_ACTIVE_COHORTS_2013_ENDPOINT = "https://cohorts.devbootcamp.com/v1/cohorts/2013/active"

  MOCK_ACTIVE_COHORTS_2013 = "[{\"name\":\"Bison 2013\",\"slug\":\"bison-2013\",\"has_group\":true,\"list_name\":\"bison.2013\",\"year\":2013,\"start_date\":\"2013-10-06\",\"on_site_date\":\"2013-12-08\",\"current_phase\":3,\"phase_zero_weeks\":9,\"holiday_break_weeks\":2,\"location\":{\"name\":\"Chicago\",\"slug\":\"chicago\"}}]"

  def stub_get_active_cohorts_2013
    WebMock.stub_request(:get, "#{RetrieveActiveCohortsMacros::DBC_ACTIVE_COHORTS_2013_ENDPOINT}").to_return(status: 200, body: RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2013)
  end


  # 2014
  MOCK_ACTIVE_CHICAGO_COHORT_NAMES_2014       = ["Otters", "Nighthawks"]
  MOCK_ACTIVE_SAN_FRANCISCO_COHORT_NAMES_2014 = ["Gopher Snakes"]

  DBC_ACTIVE_COHORTS_2014_ENDPOINT = "https://cohorts.devbootcamp.com/v1/cohorts/2014/active"

  MOCK_ACTIVE_COHORTS_2014 = "[{\"name\":\"Otters 2014\",\"slug\":\"otters-2014\",\"has_group\":true,\"list_name\":\"otters.2014\",\"year\":2014,\"start_date\":\"2013-11-25\",\"on_site_date\":\"2014-02-17\",\"current_phase\":3,\"phase_zero_weeks\":12,\"holiday_break_weeks\":0,\"location\":{\"name\":\"Chicago\",\"slug\":\"chicago\"}},{\"name\":\"Nighthawks 2014\",\"slug\":\"nighthawks-2014\",\"has_group\":true,\"list_name\":\"nighthawks.2014\",\"year\":2014,\"start_date\":\"2014-01-27\",\"on_site_date\":\"2014-04-21\",\"current_phase\":0,\"phase_zero_weeks\":12,\"holiday_break_weeks\":0,\"location\":{\"name\":\"Chicago\",\"slug\":\"chicago\"}},{\"name\":\"Gopher Snakes 2014\",\"slug\":\"gopher-snakes-2014\",\"has_group\":true,\"list_name\":\"gopher-snakes.2014\",\"year\":2014,\"start_date\":\"2014-01-27\",\"on_site_date\":\"2014-04-21\",\"current_phase\":0,\"phase_zero_weeks\":12,\"holiday_break_weeks\":0,\"location\":{\"name\":\"San Francisco\",\"slug\":\"san-francisco\"}}]"

  def stub_get_active_cohorts_2014
    WebMock.stub_request(:get, "#{RetrieveActiveCohortsMacros::DBC_ACTIVE_COHORTS_2014_ENDPOINT}").to_return(status: 200, body: RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2014)
  end


  # 2015
  MOCK_ACTIVE_COHORT_NAMES_2015 = ["Squirrels"]

  DBC_ACTIVE_COHORTS_2015_ENDPOINT = "https://cohorts.devbootcamp.com/v1/cohorts/2015/active"

  MOCK_ACTIVE_COHORTS_2015 = "[{\"name\":\"Squirrels 2015\",\"slug\":\"squirrels-2015\",\"has_group\":true,\"list_name\":\"squirrels.2015\",\"year\":2015,\"start_date\":\"2015-10-27\",\"on_site_date\":\"2015-01-12\",\"current_phase\":0,\"phase_zero_weeks\":9,\"holiday_break_weeks\":0,\"location\":{\"name\":\"Chicago\",\"slug\":\"chicago\"}}]"

  def stub_get_active_cohorts_2015
    WebMock.stub_request(:get, "#{RetrieveActiveCohortsMacros::DBC_ACTIVE_COHORTS_2015_ENDPOINT}").to_return(status: 200, body: RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2015)
  end
end
