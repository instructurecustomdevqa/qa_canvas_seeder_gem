class CanvasEnrollment < CanvasObject

  def initialize(user, section)
  end

  def self.gen_enrollment_file(opts = {})
    if(!File.file?("./users.csv"))
      raise 'Please gen_file for users before trying to generate enrollments'
    end
    if(!File.file?("./sections.csv"))
      raise 'Please gen_file for sections before trying to generate enrollments'
    end

    students_per_section = opts[:students_per_section]

    users = CSV.parse("./users.csv", headers: true)
    sections = CSV.parse("./sections.csv", headers: true)
    enrollments = []

    sections.each do |section|
      students_per_section.times do
        random_selection = rand(users.length)
        enrollments.push(Enrollment.new(users[random_selection], section))
      end
    end

    header = ["course_id", "root_account", "start_date", "end_date", "user_id", "user_integration_id", "role", "role_id", "section_id", "status", "associated_user_id", "limit_section_privileges"]

  end
end
