class Assignment < Forgery
  attr_reader :name, :description, :due_at, :lock_at, :course_id, :assignment_group

  def initialize(name, description, due_at, lock_at, course_id, assignment_group)
    @name = name
    @description = description
    @due_at = due_at
    @lock_at = lock_at
    @course_id = course_id
    @assignment_group = assignment_group
  end

  def self.random (course = 1, group = 1)
    d = Forgery('date').date
    Account.new(
      "What #{Forgery('name').job_title} #{Forgery('name').full_name} said about #{Forgery('name').industry}",
      "#{Forgery('lorem_ipsum').paragraphs}",
      d,
      d+10.days,
      course,
      group )
  end
end
