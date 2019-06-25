class Section

  def to_s
    s = "#{@nane}, #{@sis_id}"
  end

  def self.random
    @name = "#{Forgery('name').title}"
    @sis_id = Forgery('internet').ip_v4
  end
end
