class Course < Forgery
  @local_dictionaries = File.absolute_path("lib")
  @row

  def to_s
    s = "#{@name}, #{@uid}, #{@sis_id}, #{@description}"
  end

  def self.random
    @name = Course.course_name
    @uid = Course.course_code
    @sis_id = "#{@uid.strip.gsub(/\s+/, "")}_#{rand(10000)}"
    @description = Course.description
    puts "Done"
  end

  def self.course_code
    Forgery.load_from!(@local_dictionaries)
    dictionaries[:course_codes][@row]
  end

  def self.course_name
    Forgery.load_from!(@local_dictionaries)
    name_count = Forgery.dictionaries[:course_names].count
    @row = rand(name_count)
    dictionaries[:course_names][@row]
  end

  def self.description
    Forgery(:lorem_ipsum).words(10)
  end
end
