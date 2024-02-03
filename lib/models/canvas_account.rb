class CanvasAccount < CanvasObject

  attr_reader :name, :uid, :parent_uid, :root_uid, :time_zone, :sis_id, :workflow

  def to_s
    string = "#{name}, #{uid}, #{parent_uid}, #{root_uid}, #{time_zone}, #{sis_id}, #{workflow}"
  end

  def to_csv
    row = [uid, parent_uid, name, 'active', nil]
  end

  def initialize(opts = {})
    @name = opts[:name] ? opts[:name] : Faker::Company.name
    @uid = opts[:uid] ? opts[:uid] : "#{@name}-#{rand(10_000)}" 
    @parent_id = opts[:parent_id] ? opts[:parent_id] : 1 
    @root_id = opts[:root_account] ? opts[:root_account] : 1 
    @time_zone = opts[:time_zone] ? opts[:time_zone] : Faker::Address.time_zone 
    @sis_id = opts[:sis_id] ? opts[:sis_id] : (10_000+rand(10_000_000)) 
    @workflow = opts[:workflow_status] ? opts[:workflow_status] : 'active' 
  end

  def self.get_csv_headers
    header = %w[account_id parent_account_id name status integration_id]
    return header
  end

end
