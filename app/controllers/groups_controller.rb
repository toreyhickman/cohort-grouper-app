class GroupsController < ApplicationController
  def new
    @cohort = Cohort.find_by_slug(params[:cohort_id])
  end
end
