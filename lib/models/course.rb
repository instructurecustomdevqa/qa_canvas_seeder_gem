class Course < Forgery
  @local_dictionaries = File.absolute_path("lib")
  @row
  @name = ""
  @uid = Time.new.to_i.to_s
  @sis_id = ""
  @description = ""

  def self.random
    name { course_name }
    uid { course_code }
    sis_id { "#{uid.strip.gsub(/\s+/, "")}_#{rand(10000)}" }
    run_id { $runtime.to_i.to_s }
    environment_id {$test_env.id}
    description {description}
  end
end

private

def course_code
  Forgery.load_from!(@local_dictionaries)
  dictionaries[:course_codes][@row]
end

def course_name
  Forgery.load_from!(@local_dictionaries)
  name_count = Forgery.dictionaries[:course_names].count
  @row = rand(name_count)
  dictionaries[:course_names][@row]
end

def description
  Forgery(:lorem_ipsum).words(10)
end
