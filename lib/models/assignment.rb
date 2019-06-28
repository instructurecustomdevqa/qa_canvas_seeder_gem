class Assignment < Forgery
  attr_reader :name, :description, :due_at, :lock_at, :course_id, :assignment_group
  attr_writer :due_at, :lock_at

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @description = opts[:description] if opts[:description]
    @due_at = opts[:due_at] if opts[:due_at]
    @lock_at = opts[:lock_at] if opts[:lock_at]
    @course_id = opts[:course_id] if opts[:course_id]
    @assignment_group = opts[:assignment_group] if opts[:assignment_group]
  end

  def self.random (course = 1, group = 1)
    d = Forgery('date').date
    Assignment.new(
      {
        name: "What #{Forgery('name').job_title} #{Forgery('name').full_name} said about #{Forgery('name').industry}",
        description: "#{Forgery('lorem_ipsum').paragraphs}",
        due_at: d,
        lock_at: d+10.days,
        course_id: course,
        assignment_group: group
        }
      )
  end
end
