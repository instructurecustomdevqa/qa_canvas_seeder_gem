class Account < Forgery
  attr_reader :name, :uid, :parent_id, :root_id, :time_zone, :sis_id, :workflow

  def to_s
    string = "#{@name}, #{@uid}, #{@parent_id}, #{@root_id}, #{@time_zone}, #{@sis_id}, #{@workflow}"
  end

  def initialize(opts = {})
    @name = opts[:name] if opts[:name]
    @uid = opts[:uid] if opts[:uid]
    @parent_id = opts[:parent] if opts[:parent]
    @root_id = opts[:root] if opts[:root]
    @time_zone = opts[:time_zone] if opts[:time_zone]
    @sis_id = opts[:sis] if opts[:sis]
    @workflow = opts[:workflow] if opts[:workflow]
  end

  def self.random (parent_id = 1 , root_id = 1)
    a = Forgery('name').company_name
    Account.new(
      {
        name: a,
        uid: "#{a}-#{rand(10000)}",
        parent: parent_id,
        root: root_id,
        time_zone: Forgery('time').zone,
        sis_id: (10000+rand(10000000)),
        workflow: 'active'
        }
      )
  end
end
