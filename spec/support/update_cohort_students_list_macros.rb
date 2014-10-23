module UpdateCohortStudentsListMacros

  MOCK_STUDENT_COUNT = 2

  MOCK_STUDENT_A_JSON_DATA = "{\"name\":\"Some Name\",\"email\":\"some_email@host.com\",\"roles\":[\"student\"],\"profile\":{\"github\":\"https://github.com/user_a\"}}"
  MOCK_STUDENT_B_JSON_DATA = "{\"name\":\"Some Other Name\",\"email\":\"some_other_email@host.com\",\"roles\":[\"student\"],\"profile\":{\"github\":\"https://github.com/user_b\"}}"
  MOCK_TEACHER_JSON_DATA   = "{\"name\":\"Some Teacher Name\",\"email\":\"some_teacher_email@host.com\",\"roles\":[\"teacher\"],\"profile\":{\"github\":\"https://github.com/user_c\"}}"
  MOCK_STUDENTS_JSON_DATA  = "[#{UpdateCohortStudentsListMacros::MOCK_STUDENT_A_JSON_DATA},#{UpdateCohortStudentsListMacros::MOCK_STUDENT_B_JSON_DATA},#{UpdateCohortStudentsListMacros::MOCK_TEACHER_JSON_DATA}]"

  MOCK_COHORTS_RESPONSE = "{\"cohorts\":[{\"name\":\"Otters 2014\",\"students\":#{UpdateCohortStudentsListMacros::MOCK_STUDENTS_JSON_DATA}}]}"

  def stub_dbc_api_cohort_response
    WebMock.stub_request(:get, "https://api.devbootcamp.com/v1/cohorts").to_return(status: 200, body: UpdateCohortStudentsListMacros::MOCK_COHORTS_RESPONSE)
  end
end
