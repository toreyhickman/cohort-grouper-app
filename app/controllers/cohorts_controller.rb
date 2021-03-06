class CohortsController < ApplicationController
  def index
    @cohorts = RetrieveActiveCohorts.call.map do |cohort_data|
      Cohort.find_or_create_by(slug: cohort_data["slug"]) do |cohort|
        cohort.name     = cohort_data["name"]
        cohort.location = cohort_data["location"]["name"]
      end
    end

    @locations = Cohort.locations
  end

  def show
    @cohort = Cohort.find_by_param(params[:id])
  end
end
