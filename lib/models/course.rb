class Course < Forgery
  attr_reader :name, :uid, :sis_id, :description
  @@local_dictionaries = File.absolute_path("lib")
  
  def initialize(name, uid, sis, desc)
    @name = name
    @uid = uid
    @sis_id = sis
    @description = desc
  end

  def to_s
    s = "#{@name}, #{@uid}, #{@sis_id}, #{@description}"
  end

  def self.set_prefix prefix
    @@prefix = prefix
  end

  def self.random
    Course.new(
      Course.course_name,
      Course.course_code,
      (12000+rand(1000000)).to_s,
      Course.description
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
end
