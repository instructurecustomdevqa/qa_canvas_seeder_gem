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
