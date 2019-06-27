class Section < Forgery

  def initialize(name, sis_id, course, start_at, end_at)
    @name = name
    @sis_id = sis_id
    @course_id = course
    @start_at = start_at
    @end_at = end_at
  end

  def self.random(course=1)
    d = Forgery('date').date
    Section.new(
      "#{Forgery('address').country} #{Forgery('basic').color}",
      (21000+rand(1000000)),
      course,
      d,
      d+90.days
    )
  end
end
