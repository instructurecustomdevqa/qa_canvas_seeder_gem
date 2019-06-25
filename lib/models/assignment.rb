class Assignment
  @name = ""
  @description = ""

  def self.random
    name = "#{Forgery('name').last_name}'s take on #{Forgery('lorem_ipsum').title}"
    description = Forgery('lorem_ipsum').paragraphs
  end
end
