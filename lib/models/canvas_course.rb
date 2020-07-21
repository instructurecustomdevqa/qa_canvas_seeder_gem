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
        name: CanvasCourse.course_name,
        uid: CanvasCourse.course_code,
        sis: (12_000+rand(1_000_000)).to_s,
        desc: CanvasCourse.description
      }
    )
  end

  def self.course_code
    Forgery.load_from!(@@local_dictionaries)
    dictionaries[:course_codes][@@row]
  end

  def self.course_name
    Forgery.load_from!(@@local_dictionaries)
    name_count = Forgery.dictionaries[:course_names].count
    @@row = rand(name_count)
    dictionaries[:course_names][@@row]
  end

  def self.description
    Forgery(:lorem_ipsum).words(2+rand(30))
  end

  def self.gen_file(opts = {})
    opts[:rows] ? rows = opts[:rows] : rows = 0
    courses = []
    if(opts[:rows])
      rows.times do |x|
        courses.push(CanvasCourse.random)
      end
    end
    header = %w[course_id short_name long_name account_id term_id status integration_id start_date end_date course_format blueprint_course_id]
    CSV.open('./courses.csv', 'wb', write_headers: true, headers: header) do |csv|
      courses.each do |acc|
        csv << acc.to_csv
      end
    end
    return courses
  end

end
