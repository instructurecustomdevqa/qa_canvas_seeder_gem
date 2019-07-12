class CanvasSection < Forgery
  attr_reader :name, :sis_id, :start_date, :end_date
  attr_accessor :course_uid, :course_sis_id

  def to_csv
    row = [sis_id, course_sis_id, name, "active", nil, start_date, end_date]
  end

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis_id] if opts[:sis_id]
    @course_id = opts[:course] if opts[:course]
    @start_date = opts[:start_at] if opts[:start_at]
    @end_date = opts[:end_at] if opts[:end_at]
  end

  def self.random(course=1)
    d = Forgery('date').date
    CanvasSection.new(
      {
        name: "#{Forgery('address').country} #{Forgery('basic').color}",
        sis_id: (21000+rand(1000000)),
        course: course,
        start_date: d,
        end_date: d+90.days
      }
    )
  end

  def self.gen_file(opts = {})
    opts[:rows] ? rows = opts[:rows] : rows = 0
    sections = []
    if(opts[:rows])
      rows.times do |x|
        sections.push(CanvasSection.random)
      end
    end

    header = ["section_id", "course_id", "name", "status", "integration_id", "start_date", "end_date"]
    CSV.open("./sections.csv", "wb", write_headers: true, headers: header) do |csv|
      sections.each do |acc|
        csv << acc.to_csv
      end
    end
    return sections
  end

end
