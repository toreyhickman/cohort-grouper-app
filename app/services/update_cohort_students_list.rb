class UpdateCohortStudentsList

  def self.call(cohort)
    cohort.students = student_objects_from cohort_student_data(cohort.name)
  end

  private

  def self.student_objects_from(student_data)
    student_data.map do |student_datum|
      Student.find_or_create_by(email: student_datum["email"]) do |new_student|
        new_student.name = student_datum["name"]
        new_student.github = clean_github(student_datum["profile"]["github"])
      end
    end
  end

  def self.cohort_student_data(cohort_name)
    data_for_students_in get_cohort_data(cohort_name)
  end

  def self.data_for_students_in(cohort_data)
    cohort_data["students"].select { |student| student["roles"] == ["student"] }
  end

  def self.get_cohort_data(cohort_name)
    get_cohorts_data.find { |cohort| cohort["name"] == cohort_name }
  end

  def self.get_cohorts_data
    response = RestClient::Request.execute({method: :get, url: "https://api.devbootcamp.com/v1/cohorts", headers: {:Authorization => "DBC-API #{ENV['DBC_API_KEY']}" }})
    JSON[response]["cohorts"]
  end

  def self.clean_github(github_name_data)
    github_name_data.sub(/(^\S*\/)?@?(?<handle>[\w]+)/, '@\k<handle>')
  end
end
