class CanvasUser < Forgery
  attr_reader :name, :sis_id, :login_id, :email, :time_zone

  def to_s
    string = "#{name}, #{sis_id}, #{login_id}, #{email}, #{time_zone}"
  end

  def to_csv
    names = name.split(' ')
    #row = [name, sis_id, login_id, email, time_zone]
    row = [sis_id, nil, login_id, nil, nil, nil, names.first, names.last, name, "#{names.last}, #{names.first}", "#{names.first[0].downcase}#{names.last.downcase}", email, "active"]
  end

  def initialize (opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis] if opts[:sis]
    @login_id = opts[:login] if opts[:login]
    @email = opts[:email] if opts[:email]
    @time_zone = opts[:time_zone] if opts[:time_zone]
  end

  def self.random (opts = {})
    fn = Forgery('name').first_name
    ln = Forgery('name').last_name
    domain = "instructure.com"
    if opts
      opts[:email_prefix] ? epre = "#{opts[:email_prefix]}+" : epre = ''
      opts[:sis_prefix] ? sispre = "#{opts[:sis_prefix]}_" : sispre = ''
      opts[:domain] ? domain =  opts[:domain] : domain = 'instructure.com'
    end
    e = "#{epre}#{fn}.#{ln}@#{domain}"
    CanvasUser.new(
      {
        name: "#{fn} #{ln}",
        sis: "#{sispre}#{(3000+rand(1000000))}",
        login: e,
        email: e,
        time_zone: Forgery('time').zone
      }
    )
  end

  def self.gen_file(opts = {})
    opts[:rows] ? rows = opts[:rows] : rows = 0
    opts[:settings] ? settings = opts[:settings] : settings = nil
    users = []
    if(opts[:rows])
      rows.times do |x|
        users.push(CanvasUser.random(settings))
      end
    end
    #header = ["name", "sis_id", "login_id", "email", "time_zone"]
    header = ["user_id", "integration_id", "login_id", "password", "ssha_password", "authentication_provider_id", "first_name", "last_name", "full_name", "sortable_name", "short_name", "email", "status"]
    CSV.open("./users.csv", "wb", write_headers: true, headers: header) do |csv|
      users.each do |acc|
        csv << acc.to_csv
      end
    end
  end
end
