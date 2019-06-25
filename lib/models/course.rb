class Course
  @name = ""
  @uid = ""
  @sis_id = ""
  @description = ""

  def say_name
    puts @name
  end

  def self.random
    FactoryBot.create(:course)
  end
end

FactoryBot.define do
  factory :course do
    name { CourseForgery.course_name }
    uid { CourseForgery.course_code }
    sis_id { "#{uid.strip.gsub(/\s+/, "")}_#{rand(10000)}" }
    description {CourseForgery.description}
  end
end
