class CanvasUser < CanvasObject
  attr_reader :name, :sis_id, :login_id, :email, :time_zone

  @domain = 'fake-instructure.com'

  def to_s
    string = "#{name}, #{sis_id}, #{login_id}, #{email}, #{time_zone}"
  end

  def to_csv
    names = name.split(' ')
    row = [sis_id, nil, login_id, nil, nil, nil, names.first, names.last, name, "#{names.last}, #{names.first}", "#{names.first[0].downcase}#{names.last.downcase}", email, 'active']
  end

  def initialize (opts = {})
    @name = opts[:name] if opts[:name]
    @sis_id = opts[:sis] if opts[:sis]
    @login_id = opts[:login] if opts[:login]
    @email = opts[:email] if opts[:email]
    @time_zone = opts[:time_zone] if opts[:time_zone]
  end

  def self.random (opts = {})
    fn = Faker::Name.first_name
    ln = Faker::Name.last_name
    domain = 'fake-instructure.com'
    if opts
      opts[:email_prefix] ? epre = "#{opts[:email_prefix]}+" : epre = ''
      opts[:sis_prefix] ? sispre = "#{opts[:sis_prefix]}_" : sispre = ''
      opts[:domain] ? domain =  opts[:domain] : domain = 'fake-instructure.com'
    end
    e = "#{epre}#{fn}.#{ln}@#{domain}"
    CanvasUser.new(
      {
        name: "#{fn} #{ln}",
        sis: "#{sispre}#{(3_000+rand(1_000_000))}",
        login: e,
        email: e,
        time_zone: Faker::Address.time_zone
      }
    )
  end

  def self.get_csv_headers
    header = %w[user_id integration_id login_id password ssha_password authentication_provider_id first_name last_name full_name sortable_name short_name email status]
    return header
  end

end
