class GroupsController < ApplicationController
  def new
    @cohort = Cohort.find_by_slug(params[:cohort_id])

    student_list = UpdateCohortStudentsList.call(@cohort)
    past_groups = student_list.map(&:groups).reduce(:+)

    @proposed_groups = Garoupa.make_groups student_list.to_a, { past_groups: past_groups }
  end
end
