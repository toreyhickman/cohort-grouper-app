require 'rails_helper'

describe Cohort do
  let(:cohort) { create(:cohort) }

  describe ".find_by_param" do
    it "finds and returns a Cohort by its slug" do
      expect(Cohort.find_by_param(cohort.to_param)).to eq cohort
    end
  end

  describe "#mascot_name" do
    it "returns the name of the cohort mascort without a year" do
      cohort = create(:cohort, name: "Woolly Bear Caterpillars 2014")

      expect(cohort.mascot_name).to eq "Woolly Bear Caterpillars"
    end
  end
end
