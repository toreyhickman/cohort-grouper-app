require 'rails_helper'

describe UpdateCohortStudentsList do
  let(:cohort)  { create(:cohort) }
  let(:student) { create(:student) }

  before do
    stub_dbc_api_cohort_response
  end

  describe ".call" do
    it "retrieves students list from DBC API and assigns them as the cohorts students" do
      expect { UpdateCohortStudentsList.call(cohort) }.to change { cohort.students.count }.to eq UpdateCohortStudentsListMacros::MOCK_STUDENT_COUNT
    end

    it "creates records for new students" do
      expect { UpdateCohortStudentsList.call(cohort) }.to change { Student.count }.to eq UpdateCohortStudentsListMacros::MOCK_STUDENT_COUNT
    end

    it "only creates records for new students" do
      UpdateCohortStudentsList.call(cohort)

      expect { UpdateCohortStudentsList.call(cohort) }.to_not change { Student.count }
    end

    it "ends associations between cohort and students no longer in the cohort" do
      cohort.students << student

      expect{ UpdateCohortStudentsList.call(cohort) }.to change { cohort.students.include? student }.from(true).to(false)
    end
  end
end
