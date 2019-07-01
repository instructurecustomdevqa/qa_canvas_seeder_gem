class Assignment < Forgery
  attr_reader :name, :description, :due_at, :lock_at, :course_id, :assignment_group
  attr_writer :due_at, :lock_at

  def to_s
    string = "#{@name}, #{@description}, #{@due_at}, #{@lock_at}, #{@course_id}, #{@assignment_group}"
  end

  def to_csv
    row = [@name, @description, @due_at, @lock_at, @course_id, @assignment_group]
  end

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

  def self.gen_file(opts = {})
    course, group = 1
    rows = 0
    course = opts[:course] if opts[:course]
    group = opts[:group] if opts[:group]
    rows = opts[:rows] if opts[:rows]
    assignments = []
    if(opts[:rows])
      rows.times do |x|
        assignments.push(Assignment.random(course, group))
      end
    end
    CSV.open("./assignments.csv", "wb") do |csv|
      csv << ["name", "description", "due_at", "lock_at", "course_id", "assignment_group"]
      assignments.each do |acc|
        csv << acc.to_csv
      end
    end
  end

end
