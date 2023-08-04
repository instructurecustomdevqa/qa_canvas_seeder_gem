class CanvasAssignment < CanvasObject
  attr_reader :name, :description, :course_uid, :assignment_group
  attr_accessor :due_at, :lock_at, :host_info

  def to_s
    string = "#{name}, #{description}, #{due_at}, #{lock_at}, #{course_uid}, #{assignment_group}"
  end

  def to_csv
    row = [name, description, due_at, lock_at, course_uid, assignment_group]
  end

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @description = opts[:description] if opts[:description]
    @due_at = opts[:due_at] if opts[:due_at]
    @lock_at = opts[:lock_at] if opts[:lock_at]
    @course_uid = opts[:course_uid] if opts[:course_uid]
    @assignment_group = opts[:assignment_group] if opts[:assignment_group]
  end

  def self.random (course = 1, group = 1)
    d = Faker::Date.in_date_period
    CanvasAssignment.new(
      {
        name: "What #{Faker::Lorem.question}",
        description: "#{Faker::Lorem.paragraph}",
        due_at: d,
        lock_at: d+10.days,
        course_uid: course,
        assignment_group: group
        }
      )
  end

  def self.get_csv_headers
    header = %w[name description due_at lock_at course_id assignment_group]
    return header
  end

end
