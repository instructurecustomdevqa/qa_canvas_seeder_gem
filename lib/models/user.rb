class User < Forgery
  attr_reader :name, :sis_id, :login_id, :email, :time_zone

  def to_s
    string = "#{@name}, #{@sis_id}, #{@login_id}, #{@email}, #{@time_zone}"
  end

  def to_csv
    row = [@name, @sis_id, @login_id, @email, @time_zone]
  end

  def initialize (opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis] if opts[:sis]
    @login_id = opts[:login] if opts[:login]
    @email = opts[:email] if opts[:email]
    @time_zone = opts[:time_zone] if opts[:time_zone]
  end

  def self.random
    fn = Forgery('name').first_name
    ln = Forgery('name').last_name
    e = "tbyington+#{fn}.#{ln}@instructure.com"
    User.new(
      {
        name: "#{fn} #{ln}",
        sis: (3000+rand(1000000)),
        login: e,
        email: e,
        time_zone: Forgery('time').zone
      }
    )
  end

  def self.gen_file(opts = {})
    rows = 0
    rows = opts[:rows] if opts[:rows]
    users = []
    if(opts[:rows])
      rows.times do |x|
        users.push(User.random)
      end
    end
    CSV.open("./users.csv", "wb") do |csv|
      csv << ["name", "sis_id", "login_id", "email", "time_zone"]
      users.each do |acc|
        csv << acc.to_csv
      end
    end
  end
end
