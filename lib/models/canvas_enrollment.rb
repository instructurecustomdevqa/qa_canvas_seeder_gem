class CanvasEnrollment < CanvasObject
  attr_reader :section_id, :course_id, :start_date, :end_date, :user_id, :user_integration_id, :role

  def initialize(user, section, role)
    @section_id = section["section_id"]
    @course_id = section["course_id"]
    @start_date = section["start_date"]
    @end_date = section["end_date"]
    @user_id = user["user_id"]
    @user_integration_id = user["integration_id"]
    @role = role
  end

  def to_csv
    row = [course_id, 1, start_date, end_date, user_id, user_integration_id, role, nil, section_id, "active", nil, nil]
  end

  def self.gen_file(opts = {})
    if(!File.file?("./users.csv"))
      raise 'Please gen_file for users before trying to generate enrollments'
    end
    if(!File.file?("./sections.csv"))
      raise 'Please gen_file for sections before trying to generate enrollments'
    end

    students_per_section = opts[:students_per_section]

    users = CSV.read("./users.csv", headers: true)
    sections = CSV.read("./sections.csv", headers: true)
    enrollments = []

    sections.each do |section|
      students_per_section.times do
        random_selection = rand(users.length)
        enrollments.push(CanvasEnrollment.new(users[random_selection], section, "student"))
      end
    end

    header = ["course_id", "root_account", "start_date", "end_date", "user_id", "user_integration_id", "role", "role_id", "section_id", "status", "associated_user_id", "limit_section_privileges"]
    CSV.open("./enrollments.csv", "wb", write_headers: true, headers: header) do |csv|
      enrollments.each do |acc|
        csv << acc.to_csv
      end
    end
    return enrollments
  end

end
