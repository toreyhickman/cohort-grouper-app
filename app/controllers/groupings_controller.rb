class GroupingsController < ApplicationController
  def create
    cohort = Cohort.find_by_slug(params[:cohort_id])
    new_grouping = Grouping.create

    cohort.groupings << new_grouping
    redirect_to new_cohort_grouping_group_path(cohort, new_grouping)
  end
end
