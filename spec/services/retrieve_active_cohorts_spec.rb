require 'rails_helper'

describe RetrieveActiveCohorts do
  describe ".call" do
    context "in the middle of the year" do
      it "returns active cohorts for the current year" do
        allow(Date).to receive(:today) { Date.new(2014, 04, 15) }
        stub_get_active_cohorts_2014

        expect(RetrieveActiveCohorts.call).to eq JSON[RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2014]
      end
    end

    context "in December" do
      let(:expected_active_cohorts) do
        active_cohorts_2014 = JSON[RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2014]
        active_cohorts_2015 = JSON[RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2015]

        (active_cohorts_2014 + active_cohorts_2015)
      end

      it "returns active cohorts for the current and upcoming years" do
        allow(Date).to receive(:today) { Date.new(2014, 12, 18) }
        stub_get_active_cohorts_2014
        stub_get_active_cohorts_2015

        expect(RetrieveActiveCohorts.call).to eq expected_active_cohorts
      end
    end

    context "during the first two months of the year" do
      let(:expected_active_cohorts) do
        active_cohorts_2013 = JSON[RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2013]
        active_cohorts_2014 = JSON[RetrieveActiveCohortsMacros::MOCK_ACTIVE_COHORTS_2014]

        (active_cohorts_2013 + active_cohorts_2014)
      end

      it "returns active cohorts for the current and past years" do
        allow(Date).to receive(:today) { Date.new(2014, 02, 05) }
        stub_get_active_cohorts_2013
        stub_get_active_cohorts_2014

        expect(RetrieveActiveCohorts.call).to eq expected_active_cohorts
      end
    end
  end
end

