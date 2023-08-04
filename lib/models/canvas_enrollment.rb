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

  def self.get_csv_headers
    header = ["course_id", "root_account", "start_date", "end_date", "user_id", "user_integration_id", "role", "role_id", "section_id", "status", "associated_user_id", "limit_section_privileges"]
    return header
  end

end
