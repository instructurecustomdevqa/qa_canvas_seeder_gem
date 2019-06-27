class User < Forgery
  attr_reader :name, :sis_id, :login_id, :email, :time_zone

  def initialize (name, sis, login, email, time_zone)
    @name = name
    @sis_id = sis
    @login_id = login
    @email = email
    @time_zone = time_zone
  end

  def self.random
    fn = Forgery('name').first_name
    ln = Forgery('name').last_name
    e = "tbyington+#{fn}.#{ln}@instructure.com"
    User.new(
      "#{fn} #{ln}",
      (3000+rand(1000000)),
      e,
      e,
      Forgery('time').zone
    )
  end
end
