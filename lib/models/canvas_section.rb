class CanvasSection < CanvasObject
  attr_reader :name, :sis_id, :start_date, :end_date
  attr_accessor :course_uid, :course_sis_id

  def to_csv
    row = [sis_id, course_sis_id, name, 'active', nil, start_date, end_date]
  end

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis_id] if opts[:sis_id]
    @course_id = opts[:course] if opts[:course]
    @start_date = opts[:start_at] if opts[:start_at]
    @end_date = opts[:end_at] if opts[:end_at]
  end

  def self.random(opts={})
    d = Faker::Date.in_date_period
    CanvasSection.new(
      {
        name: "#{Faker::Address.country} #{Faker::Color.color_name}",
        sis_id: (21000+rand(1000000)),
        course: opts[:course_id],
        start_date: d,
        end_date: d+90.days
      }
    )
  end

  def self.get_csv_headers
    header = %w[section_id course_id name status integration_id start_date end_date]
    return header
  end

end
