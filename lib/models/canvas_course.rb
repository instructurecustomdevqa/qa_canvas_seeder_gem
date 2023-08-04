class CanvasCourse < CanvasObject
  attr_reader :name, :uid, :sis_id, :description, :account_id, :term_id, :start_date, :end_date
  @@local_dictionaries = $LOAD_PATH.grep(/bobross.*lib/).first

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @uid = opts[:uid] if opts[:uid]
    @sis_id = "#{opts[:sis]}" if opts[:sis]
    @description = opts[:desc] if opts[:desc]
    @account_id = opts[:account] if opts[:account]
    @term_id = opts[:term] if opts[:term]
    @start_date = opts[:start] if opts[:start]
    @end_date = opts[:end] if opts[:end]
  end

  def to_s
    s = "#{name}, #{uid}, #{sis_id}, #{description}"
  end

  def to_csv
    row = [sis_id, uid, name, account_id, term_id, 'active', nil, start_date, end_date, 'online', nil]
  end

  def self.set_prefix prefix
    @@prefix = prefix
  end

  def self.random
    CanvasCourse.new(
      {
        name: Faker::Educator.course_name,
        uid: Faker::Educator.subject,
        sis: (12_000+rand(1_000_000)).to_s,
        desc: Faker::Lorem.paragraph
      }
    )
  end
  
  def self.get_csv_headers
    header = %w[course_id short_name long_name account_id term_id status integration_id start_date end_date course_format blueprint_course_id]
    return header
  end

end
