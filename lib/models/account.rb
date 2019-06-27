class Account < Forgery
  attr_reader :name, :uid, :parent_id, :root_id, :time_zone, :sis_id, :workflow

  def to_s
    string = "#{@name}, #{@uid}, #{@parent_id}, #{@root_id}, #{@time_zone}, #{@sis_id}, #{@workflow}"
  end

  def initialize(name, uid, parent, root, time_zone, sis, workflow)
    @name = name
    @uid = uid
    @parent_id = parent
    @root_id = root
    @time_zone = time_zone
    @sis_id = sis
    @workflow = workflow
  end

  def self.random (parent_id = 1 , root_id = 1)
    a = Forgery('name').company_name
    Account.new(
      a,
      "#{a}-#{rand(10000)}",
      parent_id,
      root_id,
      Forgery('time').zone,
      (10000+rand(10000000)),
      'active')
  end
end
