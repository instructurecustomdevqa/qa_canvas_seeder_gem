class CanvasCourse < Forgery
  attr_reader :name, :uid, :sis_id, :description
  @@local_dictionaries = File.absolute_path("lib")

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @uid = opts[:uid] if opts[:uid]
    @sis_id = "#{opts[:sis]}" if opts[:sis]
    @description = opts[:desc] if opts[:desc]
  end

  def to_s
    s = "#{name}, #{uid}, #{sis_id}, #{description}"
  end

  def to_csv
    row = [name, uid, sis_id, description]
  end

  def self.set_prefix prefix
    @@prefix = prefix
  end

  def self.random
    CanvasCourse.new(
      {
        name: CanvasCourse.course_name,
        uid: CanvasCourse.course_code,
        sis: (12000+rand(1000000)).to_s,
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
    rows = 0
    rows = opts[:rows] if opts[:rows]
    courses = []
    if(opts[:rows])
      rows.times do |x|
        courses.push(CanvasCourse.random)
      end
    end
    header = ["name", "uid", "sis_id", "description"]
    CSV.open("./courses.csv", "wb", write_headers: true, headers: header) do |csv|
      courses.each do |acc|
        csv << acc.to_csv
      end
    end
  end
end
