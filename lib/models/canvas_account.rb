class CanvasAccount < CanvasObject

  attr_reader :name, :uid, :parent_uid, :root_uid, :time_zone, :sis_id, :workflow

  def to_s
    string = "#{name}, #{uid}, #{parent_uid}, #{root_uid}, #{time_zone}, #{sis_id}, #{workflow}"
  end

  def to_csv
    row = [uid, parent_uid, name, 'active', nil]
  end

  # future relase: Make fields reuired by canvas required here
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
    a = Faker::Company.name
    CanvasAccount.new(
      {
        name: a,
        uid: "#{a}-#{rand(10_000)}",
        parent: parent_id,
        root: root_id,
        time_zone: Faker::Address.time_zone,
        sis_id: (10_000+rand(10_000_000)),
        workflow: 'active'
        }
      )
  end

  def self.get_csv_headers
    header = %w[account_id parent_account_id name status integration_id]
    return header
  end

end
