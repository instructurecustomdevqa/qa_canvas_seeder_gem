class Section < Forgery
  attr_reader :name, :sis_id, :start_at, :end_at
  attr_accessor :course_uid, :course_sis_id

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis_id] if opts[:sis_id]
    @course_id = opts[:course] if opts[:course]
    @start_at = opts[:start_at] if opts[:start_at]
    @end_at = opts[:end_at] if opts[:end_at]
  end

  def self.random(course=1)
    d = Forgery('date').date
    Section.new(
      {
        name: "#{Forgery('address').country} #{Forgery('basic').color}",
        sis_id: (21000+rand(1000000)),
        course: course,
        start_at: d,
        end_at: d+90.days
      }
    )
  end
end
